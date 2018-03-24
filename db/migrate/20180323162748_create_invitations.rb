class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :first_user_id
      t.integer :second_user_id
      t.integer :todo_id
    end
  end
end
