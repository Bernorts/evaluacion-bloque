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

ActiveRecord::Schema.define(version: 20180918190359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competence_levels", force: :cascade do |t|
    t.integer "competence_id"
    t.integer "level_id"
    t.text    "description"
    t.index ["competence_id"], name: "index_competence_levels_on_competence_id", using: :btree
    t.index ["level_id"], name: "index_competence_levels_on_level_id", using: :btree
  end

  create_table "competences", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "semester_id"
    t.index ["semester_id"], name: "index_competences_on_semester_id", using: :btree
  end

  create_table "evaluation_evidences", force: :cascade do |t|
    t.integer  "evaluation_id"
    t.integer  "evidence_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["evaluation_id"], name: "index_evaluation_evidences_on_evaluation_id", using: :btree
    t.index ["evidence_id"], name: "index_evaluation_evidences_on_evidence_id", using: :btree
  end

  create_table "evaluations", force: :cascade do |t|
    t.date     "reqDate"
    t.date     "eval_date"
    t.integer  "desLevel"
    t.integer  "achLevel"
    t.text     "retro"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "interview_id"
    t.integer  "competence_id"
    t.integer  "user_id"
    t.index ["interview_id"], name: "index_evaluations_on_interview_id", using: :btree
  end

  create_table "evaluations_evidences", id: false, force: :cascade do |t|
    t.integer "evaluation_id", null: false
    t.integer "evidence_id",   null: false
  end

  create_table "evaluations_users", force: :cascade do |t|
    t.integer "evaluation_id"
    t.integer "user_id"
    t.boolean "responsible"
    t.integer "temporal_level"
    t.string  "retro"
    t.index ["evaluation_id", "user_id"], name: "index_evaluations_users_on_evaluation_id_and_user_id", unique: true, using: :btree
  end

  create_table "evidence_revisions", force: :cascade do |t|
    t.integer  "evidence_id"
    t.integer  "revision_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["evidence_id"], name: "index_evidence_revisions_on_evidence_id", using: :btree
    t.index ["revision_id"], name: "index_evidence_revisions_on_revision_id", using: :btree
  end

  create_table "evidences", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_evidences_on_user_id", using: :btree
  end

  create_table "grids", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "evaluated"
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "revisions", force: :cascade do |t|
    t.datetime "date"
    t.boolean  "reviewed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "semesters_users", id: false, force: :cascade do |t|
    t.integer "semester_id", null: false
    t.integer "user_id",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "role_id"
    t.string   "password_digest"
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "competences", "semesters"
  add_foreign_key "evaluations", "interviews"
  add_foreign_key "evidences", "users"
  add_foreign_key "users", "roles"
end
