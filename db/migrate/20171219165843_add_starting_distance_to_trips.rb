class AddStartingDistanceToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :starting_distance, :integer

    add_index :trips, [:vehicle_id, :starting_distance]
  end
end
