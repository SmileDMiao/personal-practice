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

ActiveRecord::Schema.define(version: 20160722044930) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "body",          limit: 4294967295
    t.integer  "replies_count", limit: 4
    t.integer  "likes_count",   limit: 4
    t.string   "user_id",       limit: 255
    t.string   "node_id",       limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string   "name",        limit: 20
    t.string   "category",    limit: 20
    t.string   "color",       limit: 20
    t.string   "odor",        limit: 20
    t.text     "description", limit: 255
    t.integer  "number",      limit: 4
    t.decimal  "price",                   precision: 5, scale: 2
    t.string   "country",     limit: 20
    t.string   "rate_flag",   limit: 10,                          default: "N"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "summary",      limit: 255
    t.integer  "section_id",   limit: 4,               null: false
    t.integer  "sort",         limit: 4,   default: 0, null: false
    t.integer  "topics_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "sort",       limit: 4,   default: 0, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "user_photos", force: :cascade do |t|
    t.string   "user_id",    limit: 255
    t.string   "file_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "auth_token",      limit: 255
    t.string   "city",            limit: 255
    t.string   "company",         limit: 255
    t.string   "github",          limit: 255
    t.string   "twitter",         limit: 255
    t.string   "avatar_name",     limit: 255
    t.string   "avatar",          limit: 255
    t.string   "language",        limit: 255, default: "zh-CN"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

end
