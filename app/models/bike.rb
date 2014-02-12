class Bike < ActiveRecord::Base

  belongs_to :station
  has_many :trips

end
