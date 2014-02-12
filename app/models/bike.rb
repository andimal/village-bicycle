class Bike < ActiveRecord::Base

  belongs_to :station
  has_many :trips

  scope :by_trips_asc, -> { order('trips_count ASC') }
  scope :by_trips_desc, -> { order('trips_count DESC') }

  def self.most_ridden
    self.by_trips_desc.first
  end

  def self.least_ridden
    self.by_trips_asc.first
  end

end
