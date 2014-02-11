class EditBikesColumns < ActiveRecord::Migration
  def change
    remove_column :bikes, :ride_count, :integer
    add_column :bikes, :station_id, :integer
    add_index :bikes, :station_id
  end
end
