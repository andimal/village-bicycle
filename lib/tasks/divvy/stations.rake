require 'csv'

namespace :divvy do

  desc "Import stations"
  task stations: :environment do

    file = File.open("#{Rails.root}/lib/assets/csv/stations.csv")
    data = CSV.parse(file, headers: true)

    # Create a station
    data.each do |row|
      station = Station.new(
        name: row[0],
        lat: row[1],
        lng: row[2],
        capacity: row[3]
      )

      if station.save
        puts "Saved station #{station.name}"
      else
        puts "Could not save #{station.name}"
      end
    end
  end


  desc "Set station IDs because Divvy is too cool to give us Station IDs in the CSV"
  task station_ids: :environment do

    file = File.open("#{Rails.root}/lib/assets/csv/trips.csv")
    data = CSV.parse(file, headers: true)

    data.each do |row|

      # To station IDs
      to_station = Station.where(name: row[6]).first
      if to_station.present? and to_station.station_id.nil?
        to_station.update_attribute(:station_id, row[5])
      end

      # From station IDs
      from_station = Station.where(name: row[8]).first
      if from_station.present? and from_station.station_id.nil?
        from_station.update_attribute(:station_id, row[7])
      end
    end
  end

end
