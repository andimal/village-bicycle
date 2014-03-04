class Station < ActiveRecord::Base

  has_many :bikes
  has_many :to_trips, class_name: "Trip", foreign_key: :to_station_id
  has_many :from_trips, class_name: "Trip", foreign_key: :from_station_id


  scope :to_trips_asc, -> { order('to_trips_count ASC') }
  scope :to_trips_desc, -> { order('to_trips_count DESC') }

  scope :from_trips_asc, -> { order('from_trips_count ASC') }
  scope :from_trips_desc, -> { order('from_trips_count DESC') }

  def self.most_left
    self.from_trips_desc.first
  end

  def self.least_left
    self.from_trips_asc.first
  end

  def self.most_arrived
    self.to_trips_desc.first
  end

  def self.least_arrived
    self.to_trips_asc.first
  end

  def self.write_static_data
    out_file = File.new("app/assets/javascripts/static-data/station-data.js", "w")
    stations = Station.from_trips_asc

    out_text = "var station_data = ["
    stations.each do |station|
      out_text = "#{out_text}{\"name\": \"#{station.name}\", \"lat\": #{station.lat}, \"lng\": #{station.lng}, \"capacity\": #{station.capacity}, \"from_trips_count\": #{station.from_trips_count}},"
    end

    out_text = "#{out_text}];"
    out_file.puts(out_text)
    out_file.close
  end

end
