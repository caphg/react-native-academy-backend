class AddCreatedAtToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :created_at, :datetime
  end
end
