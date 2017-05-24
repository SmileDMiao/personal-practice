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

ActiveRecord::Schema.define(version: 20170519203945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", id: :serial, limit: 32, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "likes_count", default: 0
    t.string "user_id"
    t.string "node_id"
    t.integer "comment_count", default: 0, null: false
    t.string "liked_user_ids", default: [], array: true
    t.string "mentioned_user_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bulk_upserts", force: :cascade do |t|
    t.string "name", limit: 20
    t.string "email", limit: 20
    t.string "city", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_bulk_name", unique: true
  end

  create_table "comments", id: :serial, limit: 32, force: :cascade do |t|
    t.text "body", null: false
    t.string "article_id", null: false
    t.string "user_id", null: false
    t.integer "likes_count", default: 0
    t.string "liked_user_ids", default: [], array: true
    t.string "mentioned_user_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exception_logs", id: :serial, limit: 32, force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", id: :serial, limit: 32, force: :cascade do |t|
    t.string "name", limit: 20
    t.string "category", limit: 20
    t.string "color", limit: 20
    t.string "odor", limit: 20
    t.text "description"
    t.integer "number"
    t.decimal "price", precision: 5, scale: 2
    t.string "country", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", id: :serial, limit: 32, force: :cascade do |t|
    t.string "send_user_id"
    t.string "receive_user_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", id: :serial, limit: 32, force: :cascade do |t|
    t.string "name"
    t.string "summary"
    t.string "section_id", limit: 32, null: false
    t.integer "sort", default: 0, null: false
    t.integer "topics_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", id: :serial, limit: 32, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "actor_id"
    t.string "notify_type", null: false
    t.string "target_type"
    t.string "target_id"
    t.string "second_target_type"
    t.string "second_target_id"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "searchable_id", limit: 32
    t.string "searchable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "sections", id: :serial, limit: 32, force: :cascade do |t|
    t.string "name"
    t.integer "sort", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "users", id: :serial, limit: 32, force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.string "auth_token"
    t.string "city"
    t.string "company"
    t.string "github"
    t.string "twitter"
    t.integer "article_count", default: 0, null: false
    t.integer "comment_count", default: 0, null: false
    t.string "favorite_article_ids", default: [], array: true
    t.string "following_ids", default: [], array: true
    t.string "follower_ids", default: [], array: true
    t.string "tagline"
    t.string "avatar_name"
    t.string "avatar"
    t.string "language", default: "zh-CN"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
