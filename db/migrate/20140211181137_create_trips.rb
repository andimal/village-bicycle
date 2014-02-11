class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :trip_id
      t.datetime :starttime
      t.datetime :stoptime
      t.integer :bike_id
      t.integer :trip_duration
      t.integer :from_station_id
      t.string :from_station_name
      t.integer :to_station_id
      t.string :to_station_name
      t.string :usertype
      t.string :gender
      t.integer :birthyear
      t.timestamps
    end
  end
end
