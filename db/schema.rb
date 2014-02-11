# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140211181137) do

  create_table "stations", force: true do |t|
    t.integer  "station_id"
    t.string   "name"
    t.decimal  "lat",        precision: 10, scale: 6
    t.decimal  "lng",        precision: 10, scale: 6
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.integer  "trip_id"
    t.datetime "starttime"
    t.datetime "stoptime"
    t.integer  "bike_id"
    t.integer  "trip_duration"
    t.integer  "from_station_id"
    t.string   "from_station_name"
    t.integer  "to_station_id"
    t.string   "to_station_name"
    t.string   "usertype"
    t.string   "gender"
    t.integer  "birthyear"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
