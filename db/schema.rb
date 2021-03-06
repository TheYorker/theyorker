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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120218225408) do

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "section_id"
    t.string   "title"
    t.string   "byline"
    t.text     "body"
    t.datetime "publish_at"
    t.integer  "visibility",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
    t.text     "editor_comments"
    t.string   "tagline"
    t.integer  "importance",      :default => 5
    t.integer  "featuredness",    :default => 0
    t.integer  "image_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "byline"
    t.text     "body"
    t.boolean  "hidden",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
    t.boolean  "anonymous",  :default => false
  end

  create_table "editors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tags"
    t.string   "source_url"
    t.string   "copyright_owner"
    t.text     "copyright_justification"
    t.string   "image_credit"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "picture_meta"
  end

  create_table "legacy_articles", :force => true do |t|
    t.integer  "old_id"
    t.string   "title"
    t.integer  "section_id"
    t.integer  "user_id"
    t.string   "byline"
    t.string   "tagline"
    t.text     "body"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legacy_articles", ["old_id"], :name => "index_legacy_articles_on_old_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privilege_lists", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "addresses"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "member"
    t.boolean  "admin",           :default => false
    t.boolean  "suspended",       :default => false
    t.boolean  "active",          :default => true
  end

end
