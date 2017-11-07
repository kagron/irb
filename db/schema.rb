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

ActiveRecord::Schema.define(version: 20171107052431) do

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "fName"
    t.string "lName"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "department"
    t.integer "typeOfApplication"
    t.string "project_title"
    t.string "sponsor_name"
    t.date "start_date"
    t.date "end_date"
    t.string "research_question"
    t.text "lit_review"
    t.text "procedure"
    t.text "pool_of_subjects"
    t.text "sub_recruitment"
    t.text "risks"
    t.text "opt_participation"
    t.text "confidentiality"
    t.text "authorities_consent"
    t.text "subjects_consent"
    t.text "parental_consent"
    t.string "advisor_sig"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
