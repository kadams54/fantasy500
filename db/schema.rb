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

ActiveRecord::Schema.define(version: 2020_08_23_130312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.string "team"
    t.string "make_model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "driver_image"
    t.string "car_image"
    t.float "qualifying_speed"
    t.integer "year"
    t.index ["number", "year"], name: "index_drivers_on_number_and_year", unique: true
  end

  create_table "drivers_teams", id: false, force: :cascade do |t|
    t.bigint "driver_id", null: false
    t.bigint "team_id", null: false
    t.index ["driver_id"], name: "index_drivers_teams_on_driver_id"
    t.index ["team_id"], name: "index_drivers_teams_on_team_id"
  end

  create_table "grids", force: :cascade do |t|
    t.integer "lap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["lap", "year"], name: "index_grids_on_lap_and_year", unique: true
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "membership_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "commish_id"
    t.integer "year"
    t.index ["commish_id"], name: "index_leagues_on_commish_id"
  end

  create_table "leagues_teams", id: false, force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "league_id", null: false
    t.index ["league_id", "team_id"], name: "index_leagues_teams_on_league_id_and_team_id"
    t.index ["team_id", "league_id"], name: "index_leagues_teams_on_team_id_and_league_id"
  end

  create_table "positions", force: :cascade do |t|
    t.integer "place"
    t.bigint "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "grid_id"
    t.integer "year"
    t.index ["driver_id"], name: "index_positions_on_driver_id"
    t.index ["grid_id"], name: "index_positions_on_grid_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "year"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "leagues", "users", column: "commish_id"
  add_foreign_key "positions", "drivers"
  add_foreign_key "positions", "grids"
  add_foreign_key "teams", "users"
end
