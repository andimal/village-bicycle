namespace :divvy do

  desc "Import all the trips"
  task trips: :environment do

    file = File.open("#{Rails.root}/lib/assets/csv/trips.csv")
    data = CSV.parse(file, headers: true)

    data.each do |row|

      trip = Trip.new(
        trip_id: row[0],
        start_time: row[1],
        stop_time: row[2],
        bike_id: row[3],
        trip_duration: row[4],
        from_station_id: row[5],
        to_station_id: row[7],
        user_type: row[9],
        gender: row[10],
        birth_year: row[11]
      )

      if trip.save!
        puts "Saved trip #{trip.trip_id}"
      else
        puts "Could not save trip..."
      end

    end
  end

end