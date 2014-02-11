class RemoveStationNamesFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :to_station_name
    remove_column :trips, :from_station_name
    rename_column :trips, :birthyear, :birth_year
    rename_column :trips, :starttime, :start_time
    rename_column :trips, :stoptime, :end_time
    rename_column :trips, :usertype, :user_type
  end
end
