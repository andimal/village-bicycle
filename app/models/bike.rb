class Bike < ActiveRecord::Base

  belongs_to :station
  has_many :trips

  def trips
    Trip.where(bike_id: self.bike_id)
  end

end
