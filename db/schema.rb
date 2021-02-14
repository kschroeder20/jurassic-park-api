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

ActiveRecord::Schema.define(version: 2021_02_12_183353) do

  create_table "cages", force: :cascade do |t|
    t.integer "max_capacity", default: 0
    t.integer "current_occupancy", default: 0
    t.boolean "active", default: true
    t.string "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dinosaurs", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.boolean "is_carnivor", default: false
    t.string "created_by"
    t.integer "cage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cage_id"], name: "index_dinosaurs_on_cage_id"
  end

end
