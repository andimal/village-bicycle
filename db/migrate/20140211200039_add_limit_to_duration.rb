class AddLimitToDuration < ActiveRecord::Migration
  def change
    change_column :trips, :trip_duration, :integer, limit: 8
  end
end
