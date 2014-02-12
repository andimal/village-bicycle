class Station < ActiveRecord::Base

  has_many :bikes
  has_many :to_trips, class_name: "Trip", foreign_key: :to_station_id
  has_many :from_trips, class_name: "Trip", foreign_key: :from_station_id

end
