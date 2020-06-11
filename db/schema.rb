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

ActiveRecord::Schema.define(version: 2020_06_11_141411) do

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

  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.integer "reviewed", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "description"
    t.integer "max_score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "description", null: false
    t.integer "competence_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competence_id"], name: "index_comments_on_competence_id"
  end

  create_table "competences", force: :cascade do |t|
    t.string "description"
    t.integer "max_penalty", null: false
    t.integer "penalty_division", default: 0, null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_competences_on_category_id"
  end

  create_table "correction_comments", force: :cascade do |t|
    t.integer "correction_id", null: false
    t.integer "comment_id", null: false
    t.string "essay_line", null: false
    t.integer "penalty", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text_cut", default: "", null: false
    t.index ["comment_id"], name: "index_correction_comments_on_comment_id"
    t.index ["correction_id"], name: "index_correction_comments_on_correction_id"
  end

  create_table "correction_competences", force: :cascade do |t|
    t.integer "correction_id", null: false
    t.integer "competence_id", null: false
    t.integer "penalty", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competence_id"], name: "index_correction_competences_on_competence_id"
    t.index ["correction_id"], name: "index_correction_competences_on_correction_id"
  end

  create_table "corrections", force: :cascade do |t|
    t.string "hash_id", default: "", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.integer "final_score", default: 0, null: false
    t.text "final_comment"
    t.boolean "valid_essay", default: true, null: false
    t.integer "student_id", null: false
    t.integer "essay_id", null: false
    t.integer "reviewer_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_corrections_on_admin_id"
    t.index ["essay_id"], name: "index_corrections_on_essay_id"
    t.index ["hash_id"], name: "index_corrections_on_hash_id", unique: true
    t.index ["reviewer_id"], name: "index_corrections_on_reviewer_id"
    t.index ["student_id"], name: "index_corrections_on_student_id"
  end

  create_table "essays", force: :cascade do |t|
    t.string "hash_id", default: "", null: false
    t.date "submission_date", null: false
    t.boolean "active", default: true
    t.integer "student_id", null: false
    t.integer "theme_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_essays_on_category_id"
    t.index ["hash_id"], name: "index_essays_on_hash_id", unique: true
    t.index ["student_id"], name: "index_essays_on_student_id"
    t.index ["theme_id"], name: "index_essays_on_theme_id"
  end

  create_table "reviewers", force: :cascade do |t|
    t.integer "reviewed", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviewers_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "registration_number"
    t.integer "submissions", default: 0, null: false
    t.integer "reviewed_submissions", default: 0, null: false
    t.integer "credits", default: 3, null: false
    t.integer "category_id", null: false
    t.integer "school_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_students_on_category_id"
    t.index ["registration_number"], name: "index_students_on_registration_number", unique: true
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "hash_id", default: "", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_id"], name: "index_themes_on_hash_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.boolean "active", default: true, null: false
    t.string "name", null: false
    t.date "birth_date", null: false
    t.string "cpf", limit: 11, null: false
    t.string "rg", limit: 9, null: false
    t.string "remember_digest"
    t.string "verification_digest"
    t.boolean "verified", default: false
    t.datetime "verified_at"
    t.string "reset_digest"
    t.datetime "reset_at"
    t.integer "role_id", default: 3, null: false
    t.integer "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["email", "username", "cpf"], name: "index_users_on_email_and_username_and_cpf", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "users"
  add_foreign_key "comments", "competences"
  add_foreign_key "competences", "categories"
  add_foreign_key "correction_comments", "comments"
  add_foreign_key "correction_comments", "corrections"
  add_foreign_key "correction_competences", "competences"
  add_foreign_key "correction_competences", "corrections"
  add_foreign_key "corrections", "admins"
  add_foreign_key "corrections", "essays"
  add_foreign_key "corrections", "reviewers"
  add_foreign_key "corrections", "students"
  add_foreign_key "essays", "categories"
  add_foreign_key "essays", "students"
  add_foreign_key "essays", "themes"
  add_foreign_key "reviewers", "users"
  add_foreign_key "students", "categories", on_delete: :cascade
  add_foreign_key "students", "schools"
  add_foreign_key "students", "users"
  add_foreign_key "users", "addresses"
  add_foreign_key "users", "roles"
end
