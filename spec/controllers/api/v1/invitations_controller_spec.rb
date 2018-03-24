require 'rails_helper'

RSpec.describe Api::V1::InvitationsController do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let(:invitation) { create(:invitation, first_user_id: user.id) }

  before do
    request.headers.merge! user.create_new_auth_token
  end

  describe '#index' do
    let!(:invite) { create(:invitation, second_user_id: user.id) }
    it 'returns list of Invitations for current user' do
      get :index

      expect(response).to have_http_status(:success)
      assert_json_response([
        {
          "id" => invite.id,
          "firstUserId"=> invite.first_user_id,
          "secondUserId"=> invite.second_user_id,
          "todoId"=> invite.todo_id,
          "firstUserEmail"=> User.find(invite.first_user_id).email,
          "todo_title"=> Todo.find(invite.todo_id).title
        }
      ], json)
    end
  end

  describe 'POST #create' do
    it 'creates invitation sucessfully' do
      post :create, params: {second_user_email: user2.email, todo_id: invitation.todo_id}
      expect(json['id']).to eq(Invitation.last.id)
      expect(json['firstUserId']).to eq(user.id)
      expect(json['secondUserId']).to eq(user2.id)
    end
  end

  describe 'POST #update' do
    let(:invite) { create(:invitation, first_user_id: user2.id, second_user_id: user.id, todo_id: invitation.todo_id)}
    it 'accepts Invitation sucessfully' do
      expect(user.todos.pluck(:id).include?(invitation.todo_id)).to eq(false)
      put :update, params: {accepted: true, id: invite.id}
      expect(user.reload.todos.pluck(:id).include?(invite.todo_id)).to eq(true)
      expect(Invitation.find_by(id: invite.id)).to eq(nil)
    end

    it 'declines Invitation sucessfully' do
      expect(user.todos.pluck(:id).include?(invitation.todo_id)).to eq(false)
      put :update, params: {accepted: false, id: invite.id}
      expect(user.todos.pluck(:id).include?(invitation.todo_id)).to eq(false)
      expect(Invitation.find_by(id: invite.id)).to eq(nil)
    end
  end

  def assert_json_response(expected_response, json)
    jsonized_expected = JSON.load(JSON.dump(expected_response))
    expect(json).to eq(jsonized_expected)
  end
end
