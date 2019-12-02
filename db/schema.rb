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

ActiveRecord::Schema.define(version: 2019_12_02_172037) do

  create_table "branches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id", null: false
    t.string "current_hash"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id", "name"], name: "index_branches_on_project_id_and_name", unique: true
    t.index ["project_id"], name: "index_branches_on_project_id"
  end

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

  create_table "runs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "scenario_id", null: false
    t.string "images_list", default: "--- []\n"
    t.string "commit_hash"
    t.integer "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["scenario_id", "commit_hash", "type"], name: "index_runs_on_scenario_id_and_commit_hash_and_type", unique: true
    t.index ["scenario_id"], name: "index_runs_on_scenario_id"
  end

  create_table "scenarios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_scenarios_on_project_id"
  end

  add_foreign_key "branches", "projects"
  add_foreign_key "events", "scenarios"
  add_foreign_key "runs", "scenarios"
  add_foreign_key "scenarios", "projects"
end
