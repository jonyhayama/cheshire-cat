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

ActiveRecord::Schema.define(version: 2020_04_21_103447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hostnames", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hostnames_records", id: false, force: :cascade do |t|
    t.bigint "hostname_id", null: false
    t.bigint "record_id", null: false
    t.index ["hostname_id", "record_id"], name: "index_hostnames_records_on_hostname_id_and_record_id"
    t.index ["record_id", "hostname_id"], name: "index_hostnames_records_on_record_id_and_hostname_id"
  end

  create_table "records", force: :cascade do |t|
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
