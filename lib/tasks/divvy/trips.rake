require 'csv'
require 'chronic'

namespace :divvy do

  desc "Import all the trips"
  task trips: :environment do

    file = File.open("#{Rails.root}/lib/assets/csv/trips.csv")
    data = CSV.parse(file, headers: true)

    data.each do |row|

      start_time = Chronic.parse(row[1])
      stop_time = Chronic.parse(row[2])

      duration = row[4].to_i

      trip = Trip.new(
        trip_id: row[0],
        start_time: start_time,
        stop_time: stop_time,
        bike_id: row[3],
        trip_duration: duration,
        from_station_id: row[5],
        to_station_id: row[7],
        user_type: row[9],
        gender: row[10],
        birth_year: row[11]
      )

      if trip.save
        puts "Saved trip #{trip.trip_id}"
      else
        puts "Could not save trip..."
      end

    end
  end
end
