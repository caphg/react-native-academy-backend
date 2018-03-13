class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate, null: false
      t.string :car_brand, null: false
      t.integer :year
      t.integer :user_id, null: false
    end

    add_index :vehicles, [:user_id, :license_plate], unique: true
  end
end
