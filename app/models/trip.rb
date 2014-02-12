class Trip < ActiveRecord::Base

  belongs_to :from_station, class_name: "Station", foreign_key: :from_station_id
  belongs_to :to_station, class_name: "Station", foreign_key: :to_station_id
  belongs_to :bike

  scope :by_duration_asc, -> { order('trip_duration ASC') }
  scope :by_duration_desc, -> { order('trip_duration DESC') }

  def self.longest_trip
    self.by_duration_desc.first
  end

  def self.shortest_trip
    self.by_duration_asc.first
  end

  def set_real_id
    self.id = self.trip_id
    self.save(validate: false)
  end
end
