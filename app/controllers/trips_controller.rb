class TripsController < ApplicationController
  
  def index
    # @trips = Trip.where( 'HOUR( start_time ) >= ? AND HOUR( start_time ) < ?', 0, 1 )
    @current_hour =  Time.zone.now.hour
  end

end