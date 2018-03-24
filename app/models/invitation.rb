class Invitation < ActiveRecord::Base
  validates :first_user_id,
            :second_user_id,
            :todo_id,
            presence: true

  TodoCannotBeSharedError = Class.new(StandardError)
end
