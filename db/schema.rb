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

ActiveRecord::Schema.define(version: 20130915143011) do

  create_table "bodies", force: true do |t|
    t.binary   "data"
    t.integer  "kind"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "model_id"
  end

  create_table "locations", force: true do |t|
    t.binary   "image"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "latspan"
    t.float    "longspan"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "model_id"
  end

  create_table "models", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "preview"
    t.float    "buildable_area"
    t.float    "area_of_site"
    t.float    "gross_area"
  end

  create_table "transforms", force: true do |t|
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.float    "xrot"
    t.float    "yrot"
    t.float    "zrot"
    t.float    "wrot"
    t.float    "xscale"
    t.float    "yscale"
    t.float    "zscale"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "body_id"
  end

end
