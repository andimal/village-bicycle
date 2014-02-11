namespace :divvy do

  desc "Create bikes from trips"
  task bikes: :environment do

    Trip.each do |trip|

      existing_bike = Bike.where(id: trip.bike_id).first rescue nil

      unless existing_bike

        bike = Bike.new(
          id: trip.bike_id,
          station_id: trip.from_station_id
        )

        if bike.save
          puts "Created bike #{bike.bike_id}"
        else
          puts "Couldn't save bike #{trip.bike_id}"
        end
      end
    end
  end
end
