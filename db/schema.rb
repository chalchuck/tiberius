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

ActiveRecord::Schema.define(version: 20151024092832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["project_id"], name: "index_memberships_on_project_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "github_id"
    t.string   "name"
    t.string   "slug"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["name"], name: "index_projects_on_name", unique: true, using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true, using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "sub_tasks", force: :cascade do |t|
    t.integer  "task_id"
    t.string   "url"
    t.string   "labels_url"
    t.string   "comments_url"
    t.string   "events_url"
    t.string   "html_url"
    t.integer  "github_id"
    t.string   "number"
    t.string   "title"
    t.string   "labels"
    t.string   "state"
    t.string   "locked"
    t.string   "comments"
    t.datetime "github_created_at"
    t.datetime "github_updated_at"
    t.datetime "closed_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "sub_tasks", ["task_id"], name: "index_sub_tasks_on_task_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "url"
    t.string   "html_url"
    t.string   "labels_url"
    t.integer  "github_id"
    t.string   "number"
    t.string   "title"
    t.string   "description"
    t.jsonb    "creator"
    t.string   "open_issues"
    t.string   "closed_issues"
    t.string   "state"
    t.datetime "due_on"
    t.datetime "closed_at"
    t.datetime "github_created_at"
    t.datetime "github_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "tasks", ["github_id"], name: "index_tasks_on_github_id", using: :btree
  add_index "tasks", ["number"], name: "index_tasks_on_number", using: :btree
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "login"
    t.string   "image"
    t.jsonb    "credentials"
    t.jsonb    "extra"
  end

  add_foreign_key "memberships", "projects"
  add_foreign_key "memberships", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "sub_tasks", "tasks"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
end
