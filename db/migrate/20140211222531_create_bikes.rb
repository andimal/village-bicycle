class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :bike_id
      t.integer :ride_count
      t.timestamps
    end
  end
end
