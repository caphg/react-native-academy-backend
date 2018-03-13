class AddDescriptionToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :description, :text
  end
end
