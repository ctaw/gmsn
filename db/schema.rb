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

ActiveRecord::Schema.define(version: 20150909131856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cash_basis_fees", force: :cascade do |t|
    t.integer  "school_year_id"
    t.integer  "year_level_id"
    t.decimal  "tuition_fee"
    t.decimal  "miscellaneous"
    t.decimal  "other_fee"
    t.decimal  "total_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts", force: :cascade do |t|
    t.string   "name"
    t.decimal  "percentage"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "due_of_payments", force: :cascade do |t|
    t.integer  "installment_basis_fee_id"
    t.string   "due_date"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "role_id"
    t.datetime "date_hired"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "installment_basis_fees", force: :cascade do |t|
    t.integer  "school_year_id"
    t.integer  "year_level_id"
    t.integer  "payment_terms"
    t.decimal  "tuition_fee"
    t.decimal  "down_payment"
    t.decimal  "other_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "student_number"
    t.integer  "school_year"
    t.string   "referrence_number"
    t.integer  "discount_id"
    t.decimal  "amount_paid"
    t.datetime "date_paid"
    t.string   "received_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pe_uniforms", force: :cascade do |t|
    t.string   "uniform_size"
    t.decimal  "amount"
    t.integer  "uniform_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_supplies", force: :cascade do |t|
    t.string   "name"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_uniforms", force: :cascade do |t|
    t.integer  "school_year_id"
    t.integer  "level"
    t.integer  "gender"
    t.string   "uniform_size"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_years", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "student_number"
    t.string   "school_year_id"
    t.integer  "payment_method"
    t.integer  "year_level_id"
    t.integer  "tuition_fee_id"
    t.string   "guardian_name"
    t.integer  "contact_number"
    t.text     "present_address"
    t.integer  "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tuition_fees", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "student_number"
    t.integer  "cash_basis_fee_id"
    t.integer  "installment_basis_fee_id"
    t.decimal  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "year_levels", force: :cascade do |t|
    t.string "name"
  end

end
