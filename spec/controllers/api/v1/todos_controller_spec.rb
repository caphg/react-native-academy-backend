require 'rails_helper'

RSpec.describe Api::V1::TodosController do
  let(:todo) { create(:todo) }
  let(:user) { todo.user }

  before do
    request.headers.merge! user.create_new_auth_token
  end

  describe '#index' do
    it 'returns list of todos for current user' do
      get :index

      expect(response).to have_http_status(:success)
      assert_json_response([
        {
          "id" => todo.id,
          "title" => todo.title,
          "description" => todo.description
        }
      ], json)
    end
  end

  describe 'POST #create' do
    let(:todo_params) {
      attributes_for(:todo).merge!(title: 'test')
    }

    it 'creates todo sucessfully' do
      post :create, params: todo_params
      expect(json['title']).to eq('test')
    end
  end

  describe 'POST #update' do
    let(:todo_params) {
      attributes_for(:todo).merge!(id: todo.id, title: 'test')
    }

    it 'updates todo sucessfully' do
      put :update, params: todo_params.merge(title: 'test2')
      expect(json['title']).to eq('test2')
    end
  end

  describe 'GET #show' do
    it 'displays a todo' do
      get :show, params: { id: todo.id }
      expect(json['title']).to eq(todo.title)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a todo' do
      delete :destroy, params: { id: todo.id }
      expect(Todo.find_by(id: todo.id).present?).to be_falsy
    end
  end

  def assert_json_response(expected_response, json)
    jsonized_expected = JSON.load(JSON.dump(expected_response))
    expect(json).to eq(jsonized_expected)
  end
end
