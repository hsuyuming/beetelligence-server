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

ActiveRecord::Schema.define(version: 2018_05_19_155426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitor_prices", force: :cascade do |t|
    t.string "imageurl"
    t.integer "price"
    t.string "source"
    t.text "title"
    t.string "update_at"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitors", force: :cascade do |t|
    t.string "imageurl"
    t.string "latitude"
    t.string "longitude"
    t.integer "price"
    t.string "source"
    t.string "title"
    t.string "url"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "catalog", default: ""
  end

  create_table "nexttimeslots", force: :cascade do |t|
    t.integer "store_id"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searchterms", force: :cascade do |t|
    t.string "user_id"
    t.string "search_term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source"
  end

end
