class Station < ActiveRecord::Base

  has_many :bikes
  has_many :trips

end
