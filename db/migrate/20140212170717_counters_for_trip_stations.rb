class CountersForTripStations < ActiveRecord::Migration
  def change
    add_column :stations, :to_trips_count, :integer
    add_column :stations, :from_trips_count, :integer
  end
end
