class AddStartAtToVehicles < ActiveRecord::Migration[5.0]
  def change
    add_column :vehicles, :start_at, :integer, default: 0
  end
end
