# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_23_143937) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "project_attacheds", force: :cascade do |t|
    t.text "comment"
    t.string "userid"
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_attacheds_on_project_id"
  end

  create_table "project_tasks", force: :cascade do |t|
    t.text "description"
    t.string "userid"
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_tasks_on_project_id"
  end

  create_table "project_threads", force: :cascade do |t|
    t.text "description"
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_threads_on_project_id"
  end

  create_table "project_users", force: :cascade do |t|
    t.string "projectid"
    t.string "userid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "wri", default: false
    t.boolean "rea", default: true
    t.boolean "del", default: false
    t.boolean "edi", default: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "projectid"
    t.string "userid"
    t.text "description"
    t.text "title"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "thread_messages", force: :cascade do |t|
    t.text "message"
    t.string "userid"
    t.integer "project_thread_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_thread_id"], name: "index_thread_messages_on_project_thread_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "authorname"
    t.string "email"
    t.string "phone"
    t.string "userid"
    t.text "password"
    t.text "contactAdd"
    t.string "right"
    t.string "login"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "password_digest"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "project_attacheds", "projects"
  add_foreign_key "project_tasks", "projects"
  add_foreign_key "project_threads", "projects"
  add_foreign_key "thread_messages", "project_threads"
  add_foreign_key "users", "projects", column: "userid"
end
