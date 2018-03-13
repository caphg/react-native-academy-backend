class CreateTodo < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.integer :user_id, null: false
    end
    add_index :todos, :user_id
  end
end
