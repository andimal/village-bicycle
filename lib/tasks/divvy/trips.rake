require 'csv'
require 'chronic'

namespace :divvy do

  desc "Import all the trips"
  task trips: :environment do

    file = File.open("#{Rails.root}/lib/assets/csv/trips.csv")
    data = CSV.parse(file, headers: true)

    # data.each do |row|
    data.take(50).each do |row|

      if row[1].gsub(/\s+/m, ' ').strip.split(" ")[1].strip.split(":")[0].to_i < 10
        start_time_date = row[1].gsub(/\s+/m, ' ').strip.split(" ")[0]
        start_time_hour = "0#{row[1].gsub(/\s+/m, ' ').strip.split(" ")[1].strip.split(":")[0]}"
        start_time_mins = row[1].gsub(/\s+/m, ' ').strip.split(" ")[1].strip.split(":")[1]
        start_time = Chronic.parse( "#{start_time_date} #{start_time_hour}:#{start_time_mins}" )
      else
        start_time = Chronic.parse(row[1])
      end

      if row[2].gsub(/\s+/m, ' ').strip.split(" ")[1].strip.split(":")[0].to_i < 10
        stop_time_date = row[2].gsub(/\s+/m, ' ').strip.split(" ")[0]
        stop_time_hour = "0#{row[2].gsub(/\s+/m, ' ').strip.split(" ")[1].strip.split(":")[0]}"
        stop_time_mins = row[2].gsub(/\s+/m, ' ').strip.split(" ")[1].strip.split(":")[1]
        stop_time = Chronic.parse( "#{stop_time_date} #{stop_time_hour}:#{stop_time_mins}" )
      else
        stop_time = Chronic.parse(row[2])
      end


      # start_time = Chronic.parse(row[1])
      # stop_time = Chronic.parse(row[2])

      duration = row[4].to_i

      # new_trip = Trip.new(
      #   trip_id: row[0],
      #   start_time: start_time,
      #   stop_time: stop_time,
      #   bike_id: row[3],
      #   trip_duration: duration,
      #   from_station_id: row[5],
      #   to_station_id: row[7],
      #   user_type: row[9],
      #   gender: row[10],
      #   birth_year: row[11]
      # )

      new_trip = Trip.find( row[0].to_i )
      new_trip.start_time = start_time
      new_trip.stop_time  = stop_time

      if new_trip.save
        puts "Saved trip #{new_trip.id}"
      else
        puts "Could not save trip..."
      end
    end
  end
end
