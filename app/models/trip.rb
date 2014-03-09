class Trip < ActiveRecord::Base

  belongs_to :from_station, class_name: "Station", foreign_key: :from_station_id, counter_cache: :from_trips_count
  belongs_to :to_station, class_name: "Station", foreign_key: :to_station_id, counter_cache: :to_trips_count
  belongs_to :bike, counter_cache: true

  scope :by_duration_asc, -> { order('trip_duration ASC') }
  scope :by_duration_desc, -> { order('trip_duration DESC') }

  scope :by_start_time_asc, -> { order('start_time ASC') }
  scope :by_start_time_desc, -> { order('start_time DESC') }

  scope :daytime_trips, -> { where('extract(hour from start_time) >= ?', 6) }
  scope :nighttime_trips, -> { where('extract(hour from start_time) < ?', 6) }

  def self.longest_trip
    self.by_duration_desc.first
  end

  def self.shortest_trip
    self.by_duration_asc.first
  end

  def self.write_hourly_data
    (0..23).each do |hour|
      if hour < 10
        hour = "0#{hour}"
      end

      adjusted_time = hour.to_i + 5
      if adjusted_time > 23
        adjusted_time = adjusted_time - 24
      end

      out_file = File.new("app/assets/javascripts/static-data/trip-data-#{hour}.js", "w")
      trips = Trip.where( 'HOUR( start_time ) >= ? AND HOUR( start_time ) < ?', "#{adjusted_time}", "#{adjusted_time + 1}" )

      out_text = "var trip_data_#{hour} = ["
      trips.each do |trip|
        if trip.directions_points.present?
          directions = trip.directions_points.gsub!("\\", "\\\\\\") 
          out_text = "#{out_text}'#{directions ? directions : trip.directions_points}',"
        end
      end

      out_text = "#{out_text}];"
      out_file.puts(out_text)
      out_file.close
    end
  end

  def self.write_hourly_duration
    out_file = File.new("app/assets/javascripts/static-data/trip-duration.js", "w")
    out_text = "var trip_duration = ["

    (0..23).each do |hour|
      if hour < 10
        hour = "0#{hour}"
      end

      adjusted_time = hour.to_i + 5
      if adjusted_time > 23
        adjusted_time = adjusted_time - 24
      end

      trips = Trip.where( 'HOUR( start_time ) >= ? AND HOUR( start_time ) < ?', "#{adjusted_time}", "#{adjusted_time + 1}" )
      trip_duration = 0
      
      trips.each do |trip|
        trip_duration += trip.trip_duration
      end

      out_text = "#{out_text}#{( trip_duration / 60 ) / 60},"

    end

    out_text = "#{out_text}];"
    out_file.puts(out_text)
    out_file.close

  end

  def set_directions_points
    require 'net/http'
    directions = JSON.parse Net::HTTP.get(URI.parse("http://maps.googleapis.com/maps/api/directions/json?origin=#{self.from_station.lat},#{self.from_station.lng}&destination=#{self.to_station.lat},#{self.to_station.lng}&sensor=false&mode=bicycling"))
    self.directions_points = directions['routes'].first['overview_polyline']['points']
    self.save
  end
  
end
