class AddAmountTraveledToVehicles < ActiveRecord::Migration[5.0]
  def change
    add_column :vehicles, :amount_traveled, :integer, null: false, default: 0
  end
end
