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

ActiveRecord::Schema.define(version: 2023_09_03_173805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.datetime "date"
    t.decimal "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.decimal "tax"
    t.string "payment_mode"
    t.integer "student_id"
    t.string "class_no"
    t.bigint "cheque_no"
    t.bigint "receipt_number"
    t.string "bank_account"
    t.datetime "discarded_at"
    t.string "month_from"
    t.string "month_to"
    t.integer "discarded_by"
    t.string "notes"
    t.integer "status", default: 0
    t.index ["discarded_at"], name: "index_invoices_on_discarded_at"
  end

  create_table "particulars", force: :cascade do |t|
    t.string "fee_type"
    t.decimal "amount"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.integer "discarded_by"
    t.index ["discarded_at"], name: "index_particulars_on_discarded_at"
    t.index ["invoice_id"], name: "index_particulars_on_invoice_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "admission_no"
    t.bigint "phone_number"
    t.string "grade"
    t.string "section"
    t.string "father_name"
    t.string "mother_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "dob"
    t.date "date_of_admission"
    t.datetime "discarded_at"
    t.jsonb "pending_fees"
    t.boolean "fee_pending"
    t.integer "sms_status", default: 0
    t.integer "sms_sent_count", default: 0
    t.datetime "sent_at"
    t.string "message"
    t.string "email"
    t.index ["discarded_at"], name: "index_students_on_discarded_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.bigint "phonenum"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phonenum"], name: "index_users_on_phonenum", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "particulars", "invoices"
end
