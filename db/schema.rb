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

ActiveRecord::Schema[7.0].define(version: 2023_04_11_123447) do
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

  create_table "circuits", force: :cascade do |t|
    t.string "nom"
    t.string "pays"
    t.string "adresse"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string "nom"
    t.integer "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "saison_id"
    t.index ["saison_id"], name: "index_divisions_on_saison_id"
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nom"
    t.string "couleur"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.time "horaire"
    t.integer "numero"
    t.integer "circuit_id", null: false
    t.integer "division_id", null: false
    t.integer "ligue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circuit_id"], name: "index_events_on_circuit_id"
    t.index ["division_id"], name: "index_events_on_division_id"
    t.index ["ligue_id"], name: "index_events_on_ligue_id"
  end

  create_table "friends", force: :cascade do |t|
    t.string "nom"
    t.integer "age"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ligues", force: :cascade do |t|
    t.string "nom"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pilotes", force: :cascade do |t|
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resultats", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "pilote_id", null: false
    t.integer "equipe_id", null: false
    t.integer "qualification"
    t.integer "course"
    t.boolean "dotd"
    t.boolean "mt"
    t.integer "score"
    t.boolean "dnf"
    t.boolean "dns"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipe_id"], name: "index_resultats_on_equipe_id"
    t.index ["event_id"], name: "index_resultats_on_event_id"
    t.index ["pilote_id"], name: "index_resultats_on_pilote_id"
  end

  create_table "saisons", force: :cascade do |t|
    t.string "nom"
    t.integer "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ligue_id"
    t.index ["ligue_id"], name: "index_saisons_on_ligue_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "divisions", "saisons"
  add_foreign_key "events", "circuits"
  add_foreign_key "events", "divisions"
  add_foreign_key "events", "ligues"
  add_foreign_key "resultats", "equipes"
  add_foreign_key "resultats", "events"
  add_foreign_key "resultats", "pilotes"
  add_foreign_key "saisons", "ligues"
end
