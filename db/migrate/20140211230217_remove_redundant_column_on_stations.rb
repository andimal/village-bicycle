class RemoveRedundantColumnOnStations < ActiveRecord::Migration
  def change
    remove_column :stations, :station_id, :integer
    remove_column :bikes, :bike_id, :integer
  end
end
