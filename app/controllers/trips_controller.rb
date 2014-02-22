class TripsController < ApplicationController
  
  def index
    @trips = Trip.where( 'HOUR( start_time ) >= ? AND HOUR( start_time ) < ?', 13, 14 )
    # @trips = Trip.take(1000)
    @trip = Trip.first

    # require 'net/http'
    # @directions = JSON.parse Net::HTTP.get(URI.parse('http://maps.googleapis.com/maps/api/directions/json?origin=41.88338,-87.64117&destination=41.897764,-87.642884&sensor=false&mode=bicycling'))
    # @points = @directions['routes'].first['overview_polyline']['points']
    # p GoogleDirections.new("#{@trip.from_station.lat}#{@trip.from_station.lng}", "#{@trip.to_station.lat}#{@trip.to_station.lng}", {})

    @current_hour =  Time.zone.now.hour
  end

end