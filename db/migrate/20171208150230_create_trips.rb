class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.integer :total_distance, null: false
      t.integer :vehicle_id, null: false
      t.string :starting_point_name
      t.string :ending_point_name
      t.date :date, null: false
      t.boolean :is_official, default: true
    end

    add_index :trips, :vehicle_id
    add_index :trips, [:vehicle_id, :is_official]
    add_index :trips, [:vehicle_id, :date]
  end
end
