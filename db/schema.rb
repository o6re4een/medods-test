# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_25_092023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bmr_histories", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "formula_id", null: false
    t.decimal "result", precision: 6, scale: 2, null: false
    t.date "calculated_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formula_id"], name: "index_bmr_histories_on_formula_id"
    t.index ["patient_id", "formula_id", "calculated_on"], name: "index_bmr_on_patient_formula_date", unique: true
    t.index ["patient_id"], name: "index_bmr_histories_on_patient_id"
  end

  create_table "doctor_patients", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "patient_id"], name: "index_doctor_patients_on_doctor_id_and_patient_id", unique: true
    t.index ["doctor_id"], name: "index_doctor_patients_on_doctor_id"
    t.index ["patient_id"], name: "index_doctor_patients_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name", "middle_name"], name: "index_doctors_on_first_name_and_last_name_and_middle_name", unique: true
  end

  create_table "formulas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_formulas_on_name"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genders_on_name", unique: true
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_name"
    t.bigint "gender_id", null: false
    t.date "birthday", null: false
    t.integer "height", null: false
    t.decimal "weight", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name", "middle_name", "birthday"], name: "index_patients_identity", unique: true
    t.index ["gender_id"], name: "index_patients_on_gender_id"
  end

  add_foreign_key "bmr_histories", "formulas"
  add_foreign_key "bmr_histories", "patients"
  add_foreign_key "doctor_patients", "doctors"
  add_foreign_key "doctor_patients", "patients"
  add_foreign_key "patients", "genders"
end
