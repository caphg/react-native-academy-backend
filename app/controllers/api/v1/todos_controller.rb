# frozen_string_literal: true

module Api::V1
  class TodosController < ApplicationController
    before_action :authenticate_user!

    def index
      todos = current_user.todos
      render json: todos.map { |v| TodoPresenter.new.as_json(v) }
    end

    def create
      todo = current_user.todos.create(todo_params)
      todo.save!
      render json: TodoPresenter.new.as_json(todo)
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound => e
      render json: json_error(e), status: :not_found
    end

    def show
      render json: TodoPresenter.new.as_json(todo)
    end

    def update
      todo.update!(todo_params)
      render json: TodoPresenter.new.as_json(todo.reload)
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound => e
      render json: json_error(e), status: :not_found
    end

    def destroy
      Invitation.where(todo_id: todo.id).destroy_all
      todo.destroy!
      head(204)
    rescue ActiveRecord::RecordNotFound => e
      render json: json_error(e), status: :not_found
    end

    private

    def todo
      @todo ||= current_user.todos.find_by!(id: params[:id])
    end

    def todo_params
      params.permit(:id, :image_url, :title, :description, contacts_attributes: [:id, :name, :phone, :_destroy])
    end
  end
end
