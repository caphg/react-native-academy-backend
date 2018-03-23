class AddImageUrlToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :image_url, :string
  end
end
