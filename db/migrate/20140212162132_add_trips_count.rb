class AddTripsCount < ActiveRecord::Migration
  def change
    add_column :bikes, :trips_count, :integer
  end
end
