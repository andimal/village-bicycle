class OneMoreColumnRename < ActiveRecord::Migration
  def change
    rename_column :trips, :end_time, :stop_time
  end
end
