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

ActiveRecord::Schema[7.1].define(version: 2024_07_31_023419) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bulletins", force: :cascade do |t|
    t.string "title"
    t.datetime "date"
    t.string "location"
    t.text "description"
    t.string "ngo_name"
    t.boolean "saved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "attachable_type", null: false
    t.integer "attachable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_documents_on_attachable"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "ngo_users_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ngo_users_id"], name: "index_messages_on_ngo_users_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "ngo_users", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "contact_number"
    t.string "website"
  end

  create_table "saved_posts", force: :cascade do |t|
    t.string "title"
    t.datetime "date"
    t.string "location"
    t.text "description"
    t.string "ngo_name"
    t.boolean "saved"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bulletin_id"
    t.index ["user_id"], name: "index_saved_posts_on_user_id"
  end

  create_table "user_histories", force: :cascade do |t|
    t.text "description"
    t.date "date"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activity_type"
    t.string "activity_title"
    t.index ["user_id"], name: "index_user_histories_on_user_id"
  end

  create_table "user_particulars", force: :cascade do |t|
    t.string "full_name"
    t.string "phone_number_country_code"
    t.string "phone_number"
    t.string "full_phone_number"
    t.string "secondary_phone_number_country_code"
    t.string "secondary_phone_number"
    t.string "full_secondary_phone_number"
    t.string "country_of_origin"
    t.string "ethnicity"
    t.string "religion"
    t.string "gender"
    t.date "date_of_birth"
    t.date "date_of_arrival"
    t.string "photo_url"
    t.string "birth_certificate_url"
    t.string "passport_url"
    t.string "verifier_ngo"
    t.integer "unique_id", limit: 4
    t.integer "two_fa_passcode", limit: 3
    t.string "status"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_particulars_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.boolean "registered"
    t.boolean "needs_document_upload"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "messages", "ngo_users", column: "ngo_users_id"
  add_foreign_key "messages", "users"
  add_foreign_key "saved_posts", "users"
  add_foreign_key "user_histories", "users"
  add_foreign_key "user_particulars", "users"
end
