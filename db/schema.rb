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

ActiveRecord::Schema.define(version: 20161208125318) do

  create_table "active_store_templates", force: :cascade do |t|
    t.integer  "store_id",      limit: 4
    t.integer  "email_type_id", limit: 4
    t.integer  "template_id",   limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "active_store_templates", ["email_type_id"], name: "index_active_store_templates_on_email_type_id", using: :btree
  add_index "active_store_templates", ["store_id"], name: "index_active_store_templates_on_store_id", using: :btree
  add_index "active_store_templates", ["template_id"], name: "index_active_store_templates_on_template_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.string   "data_fingerprint",  limit: 255
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "email_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "event_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "smtp_details", force: :cascade do |t|
    t.integer  "store_id",        limit: 4
    t.string   "delivery_method", limit: 255
    t.string   "address",         limit: 255
    t.integer  "port",            limit: 4
    t.string   "domain",          limit: 255
    t.string   "username",        limit: 255
    t.string   "password",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "smtp_details", ["store_id"], name: "index_smtp_details_on_store_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "store_hash",   limit: 255
    t.string   "access_token", limit: 255
    t.text     "scope",        limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "username",     limit: 255
    t.string   "email",        limit: 255
  end

  create_table "templates", force: :cascade do |t|
    t.integer  "store_id",      limit: 4
    t.integer  "email_type_id", limit: 4
    t.string   "subject",       limit: 255
    t.text     "body",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",          limit: 255
    t.boolean  "active"
    t.integer  "event_id",      limit: 4
    t.integer  "event_type_id", limit: 4
  end

  add_index "templates", ["email_type_id"], name: "index_templates_on_email_type_id", using: :btree
  add_index "templates", ["store_id"], name: "index_templates_on_store_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
