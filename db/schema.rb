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

ActiveRecord::Schema.define(version: 20160722092645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "replies_count"
    t.integer  "likes_count",    default: 0
    t.string   "user_id"
    t.string   "node_id"
    t.integer  "comment_count",  default: 0,  null: false
    t.integer  "liked_user_ids", default: [],              array: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body",                            null: false
    t.string   "article_id",                      null: false
    t.string   "user_id",                         null: false
    t.integer  "likes_count",        default: 0
    t.integer  "liked_user_ids",     default: [],              array: true
    t.integer  "mentioned_user_ids", default: [],              array: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string   "name",        limit: 20
    t.string   "category",    limit: 20
    t.string   "color",       limit: 20
    t.string   "odor",        limit: 20
    t.text     "description"
    t.integer  "number"
    t.decimal  "price",                  precision: 5, scale: 2
    t.string   "country",     limit: 20
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name"
    t.string   "summary"
    t.string   "section_id",   limit: 32,             null: false
    t.integer  "sort",                    default: 0, null: false
    t.integer  "topics_count",            default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.integer  "sort",       default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "city"
    t.string   "company"
    t.string   "github"
    t.string   "twitter"
    t.integer  "article_count",        default: 0,       null: false
    t.integer  "comment_count",        default: 0,       null: false
    t.integer  "favorite_article_ids", default: [],                   array: true
    t.integer  "following_ids",        default: [],                   array: true
    t.integer  "follower_ids",         default: [],                   array: true
    t.string   "avatar_name"
    t.string   "avatar"
    t.string   "language",             default: "zh-CN"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

end
