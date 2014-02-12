class RemoveStationFromBike < ActiveRecord::Migration
  def change
    remove_column :bikes, :station_id, :integer
  end
end
