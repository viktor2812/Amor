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

ActiveRecord::Schema.define(version: 20160907215415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "cardNumber"
    t.date     "expDate"
    t.string   "emisor"
    t.integer  "statuss"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.string   "sub_company"
    t.string   "payment_schema"
    t.string   "contact_name"
    t.string   "contact_p_last_name"
    t.string   "contact_m_last_name"
    t.string   "contact_email"
    t.integer  "contact_telephone",   limit: 8
    t.string   "rfc_company"
    t.string   "street"
    t.integer  "num_out"
    t.integer  "num_int"
    t.string   "location"
    t.string   "delegation"
    t.string   "city"
    t.integer  "cp"
    t.string   "agent_name"
    t.string   "agent_p_last_name"
    t.string   "agent_m_last_name"
    t.string   "agent_email"
    t.integer  "agent_telephone",     limit: 8
    t.string   "rfc_agent"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
  end

  create_table "destroyers", force: :cascade do |t|
    t.string   "card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "curp"
    t.float    "net_monthly_salary"
    t.date     "admission_date"
    t.integer  "employee_key",        limit: 8
    t.string   "payment_cycle"
    t.integer  "card_id"
    t.integer  "company_id"
    t.integer  "mobile_number",       limit: 8
    t.integer  "phone",               limit: 8
    t.string   "activation_code"
    t.string   "p_last_name"
    t.string   "m_last_name"
    t.date     "birthdate"
    t.string   "place_birth"
    t.float    "brut_monthly_salary"
    t.string   "disponible"
    t.string   "credit_line"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "companies_id"
    t.integer  "cards_id"
  end

  add_index "employees", ["cards_id"], name: "index_employees_on_cards_id", using: :btree
  add_index "employees", ["companies_id"], name: "index_employees_on_companies_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.integer  "employee_id"
    t.float    "net_salary"
    t.integer  "interest"
    t.float    "max_credit"
    t.integer  "period"
    t.float    "capital_requisition"
    t.date     "date_requisition"
    t.float    "capital_to_pay"
    t.float    "balance"
    t.string   "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "employees_id"
  end

  add_index "loans", ["employees_id"], name: "index_loans_on_employees_id", using: :btree

  create_table "pagos", force: :cascade do |t|
    t.integer  "loan_id"
    t.float    "monto_pago"
    t.float    "interes"
    t.float    "iva_sobre_interes"
    t.float    "total"
    t.string   "status_pago"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "loans_id"
  end

  add_index "pagos", ["loans_id"], name: "index_pagos_on_loans_id", using: :btree

  create_table "reportes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "employees", "cards"
  add_foreign_key "employees", "companies"
  add_foreign_key "loans", "employees"
  add_foreign_key "pagos", "loans"
end
