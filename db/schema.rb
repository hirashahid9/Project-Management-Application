# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_31_055046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bugs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "types"
    t.string "status"
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "image"
    t.bigint "creator_id", null: false
    t.bigint "developer_id"
    t.index ["creator_id"], name: "index_bugs_on_creator_id"
    t.index ["developer_id"], name: "index_bugs_on_developer_id"
    t.index ["project_id"], name: "index_bugs_on_project_id"
    t.index ["slug"], name: "index_bugs_on_slug", unique: true
    t.index ["status"], name: "index_bugs_on_status"
    t.index ["types"], name: "index_bugs_on_types"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "projects", force: :cascade do |t|
    t.text "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "manager_id"
    t.string "slug"
    t.index ["manager_id"], name: "index_projects_on_manager_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_id", null: false
    t.string "name"
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "bugs", "projects"
  add_foreign_key "bugs", "users", column: "creator_id"
  add_foreign_key "bugs", "users", column: "developer_id"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "users"
  add_foreign_key "users", "roles"
end
