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

ActiveRecord::Schema.define(version: 2018_02_07_133353) do

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.integer "pages"
    t.string "available"
    t.integer "library_id"
    t.integer "section_id"
  end

  create_table "booksharemembers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "library_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "address_street"
    t.string "address_city"
    t.string "address_state"
    t.string "address_zipcode"
    t.string "hours_of_operation"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "library_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.integer "age"
    t.integer "start_year"
    t.integer "library_id"
    t.string "email"
    t.string "address"
    t.boolean "librarian", default: true
  end

end
