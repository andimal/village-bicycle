class TripsController < ApplicationController
  
  def index
    @trip = Trip.first
  end

end