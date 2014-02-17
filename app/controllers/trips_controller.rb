class TripsController < ApplicationController
  
  def index
    # @trip = Trip.first
    @current_hour =  Time.new.localtime.strftime("%H")
  end

end