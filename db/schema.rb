# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_19_205959) do

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.json "data"
    t.bigint "time"
    t.bigint "scenario_id", null: false
    t.index ["scenario_id", "time"], name: "index_events_on_scenario_id_and_time", unique: true
    t.index ["scenario_id"], name: "index_events_on_scenario_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "repository_link"
    t.string "production_url"
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_repo"
    t.string "repository_name"
  end

  create_table "scenarios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "images", default: "--- []\n"
    t.string "commit_hash"
    t.bigint "base_id"
    t.index ["base_id"], name: "index_scenarios_on_base_id"
    t.index ["project_id"], name: "index_scenarios_on_project_id"
  end

  add_foreign_key "events", "scenarios"
  add_foreign_key "scenarios", "projects"
end
