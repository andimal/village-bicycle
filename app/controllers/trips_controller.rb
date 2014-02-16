class TripsController < ActionController::Base
  
  def index
    @trip = Trip.first
  end

end