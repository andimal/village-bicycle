namespace :divvy do

  desc "Create bikes from trips"
  task bikes: :environment do

    Trip.all.each do |trip|
      bike = Bike.find_or_create_by(id: trip.bike_id) rescue nil
    end
  end
end
