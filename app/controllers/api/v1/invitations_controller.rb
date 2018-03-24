# frozen_string_literal: true

module Api::V1
  class InvitationsController < ApplicationController
    before_action :authenticate_user!

    def index
      render json: invitations.map { |v| InvitationPresenter.new.as_json(v) }
    end

    def create
      invitation = CreateInviteService.new(current_user).(invitation_params)
      render json: InvitationPresenter.new.as_json(invitation)
    rescue Invitation::TodoCannotBeSharedError => e
      render json: json_error(e), status: :unprocessable_entity
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :not_found
    end

    def update
      resp = invitation_params[:accepted] ? TodoPresenter.new.as_json(todo) : {}
      AcceptRejectInviteService.new(current_user).(invitation_params)
      render json: resp
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :not_found
    end

    private

    def invitation
      @invitation ||= Invitation.find(params[:id])
    end

    def invitations
      @invitations ||= Invitation.where(second_user_id: current_user.id)
    end

    def todo
      Todo.find(invitation.todo_id)
    end

    def invitation_params
      params.permit(:id, :second_user_email, :todo_id, :accepted)
    end
  end
end
