class RemoveUserIdFromTodos < ActiveRecord::Migration[5.0]
  def change
    remove_column :todos, :user_id, :integer
  end
end
