class TripsController < ApplicationController
  
  def index
    # @trip = Trip.first
    @current_hour =  Time.now.hour
  end

end