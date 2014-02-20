class AddDirectionsPointsToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :directions_points, :text
  end
end
