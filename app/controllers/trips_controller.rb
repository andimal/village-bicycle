class TripsController < ApplicationController
  
  def index
    # @trip = Trip.first
    @current_hour =  Time.zone.now.hour
  end

end