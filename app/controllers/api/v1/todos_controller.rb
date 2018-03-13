# frozen_string_literal: true

module Api::V1
  class TodosController < ApplicationController
    before_action :authenticate_user!

    def index
      todos = Todo.for_user(current_user)
      render json: todos.map { |v| TodoPresenter.new.as_json(v) }
    end

    def create
      todo = current_user.todos.build(todo_params)
      todo.save!
      render json: TodoPresenter.new.as_json(todo)
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :not_found
    end

    def show
      render json: TodoPresenter.new.as_json(todo)
    end

    def update
      todo.update!(todo_params)
      render json: TodoPresenter.new.as_json(todo.reload)
    rescue ActiveRecord::RecordInvalid => e
      render json: json_error(e), status: :not_found
    end

    def destroy
      todo.destroy!
      head(204)
    end

    private

    def todo
      @todo ||= current_user.todos.find_by(id: params[:id])
    end

    def todo_params
      params.permit(:id, :title, :description)
    end
  end
end
