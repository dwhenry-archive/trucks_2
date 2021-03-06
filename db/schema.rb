# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090801204443) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "abn"
    t.string   "address1"
    t.string   "address2"
    t.string   "town"
    t.string   "state"
    t.string   "postcode"
    t.string   "pref_type"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loads", :force => true do |t|
    t.string   "load_type"
    t.string   "start_loc"
    t.float    "start_lat"
    t.float    "start_lng"
    t.string   "end_loc"
    t.float    "end_lat"
    t.float    "end_lng"
    t.float    "distance"
    t.date     "load_date"
    t.integer  "company_id", :limit => 11
    t.text     "details"
    t.boolean  "filled",                   :default => false
    t.boolean  "deleted",                  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "map_points", :force => true do |t|
    t.integer  "load_id",    :limit => 11
    t.string   "point_type"
    t.string   "load_type"
    t.float    "lat"
    t.float    "lng"
    t.float    "point_dist"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "map_points", ["load_type", "point_type"], :name => "index_map_points_on_load_type_and_point_type"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.datetime "last_action"
    t.string   "ip_address"
    t.integer  "company_id",                :limit => 11
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
