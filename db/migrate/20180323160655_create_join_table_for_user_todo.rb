class CreateJoinTableForUserTodo < ActiveRecord::Migration[5.0]
  def change
    create_join_table :todos, :users do |t|
      t.index :todo_id
      t.index :user_id
    end
  end
end
