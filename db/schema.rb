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

ActiveRecord::Schema[7.0].define(version: 2023_12_22_233208) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "titre"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_product_id"
    t.string "stripe_price_id"
    t.integer "montant"
    t.boolean "abonnement"
    t.integer "niveau"
    t.integer "bonus_paris"
  end

  create_table "association_admins", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "ligue_id", null: false
    t.boolean "admin"
    t.boolean "valide"
    t.boolean "actif"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ligue_id"], name: "index_association_admins_on_ligue_id"
    t.index ["user_id"], name: "index_association_admins_on_user_id"
  end

  create_table "association_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "ligue_id", null: false
    t.integer "division_id"
    t.integer "equipe_id"
    t.boolean "pilote"
    t.boolean "admin"
    t.boolean "valide"
    t.boolean "actif"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rattachement_id"
    t.index ["division_id"], name: "index_association_users_on_division_id"
    t.index ["equipe_id"], name: "index_association_users_on_equipe_id"
    t.index ["ligue_id"], name: "index_association_users_on_ligue_id"
    t.index ["rattachement_id"], name: "index_association_users_on_rattachement_id"
    t.index ["user_id"], name: "index_association_users_on_user_id"
  end

  create_table "base_setups", force: :cascade do |t|
    t.string "parametre"
    t.decimal "val_min"
    t.decimal "val_max"
    t.text "explication"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "categorie_parametre_id"
    t.integer "game_id", null: false
    t.index ["categorie_parametre_id"], name: "index_base_setups_on_categorie_parametre_id"
    t.index ["game_id"], name: "index_base_setups_on_game_id"
  end

  create_table "bonus_paris", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "montant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bonus_paris_on_user_id"
  end

  create_table "categorie_parametres", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "val_categorie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_categorie_parametres_on_game_id"
  end

  create_table "circuits", force: :cascade do |t|
    t.string "nom"
    t.string "pays"
    t.string "carte"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comportement_base_setups", force: :cascade do |t|
    t.integer "base_setup_id", null: false
    t.integer "comportement_id", null: false
    t.string "sens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_setup_id"], name: "index_comportement_base_setups_on_base_setup_id"
    t.index ["comportement_id"], name: "index_comportement_base_setups_on_comportement_id"
  end

  create_table "comportements", force: :cascade do |t|
    t.string "nom"
    t.boolean "principal"
    t.string "label_categorie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "correctifs", force: :cascade do |t|
    t.integer "base_setup_id", null: false
    t.integer "setup_id"
    t.string "nom"
    t.string "sens"
    t.integer "problem_id", null: false
    t.integer "problem_second_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_setup_id"], name: "index_correctifs_on_base_setup_id"
    t.index ["problem_id"], name: "index_correctifs_on_problem_id"
    t.index ["problem_second_id"], name: "index_correctifs_on_problem_second_id"
    t.index ["setup_id"], name: "index_correctifs_on_setup_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.integer "saison_id", null: false
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived"
    t.index ["saison_id"], name: "index_divisions_on_saison_id"
  end

  create_table "dois", force: :cascade do |t|
    t.integer "demandeur_id"
    t.integer "implique_id", null: false
    t.integer "event_id", null: false
    t.text "description"
    t.string "lien"
    t.string "decision"
    t.integer "reglement_id"
    t.integer "penalite"
    t.string "penalite_temps"
    t.text "commentaire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "association_admin_id"
    t.boolean "doicommissaire"
    t.index ["association_admin_id"], name: "index_dois_on_association_admin_id"
    t.index ["demandeur_id"], name: "index_dois_on_demandeur_id"
    t.index ["event_id"], name: "index_dois_on_event_id"
    t.index ["implique_id"], name: "index_dois_on_implique_id"
    t.index ["reglement_id"], name: "index_dois_on_reglement_id"
  end

  create_table "dotds", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "association_user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["association_user_id"], name: "index_dotds_on_association_user_id"
    t.index ["event_id"], name: "index_dotds_on_event_id"
    t.index ["user_id"], name: "index_dotds_on_user_id"
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nom"
    t.string "couleurs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "circuit_id", null: false
    t.integer "division_id", null: false
    t.datetime "horaire"
    t.integer "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circuit_id"], name: "index_events_on_circuit_id"
    t.index ["division_id"], name: "index_events_on_division_id"
  end

  create_table "friends", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "nom"
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licences", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "association_user_id", null: false
    t.integer "gain"
    t.integer "perte"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["association_user_id"], name: "index_licences_on_association_user_id"
    t.index ["event_id"], name: "index_licences_on_event_id"
  end

  create_table "ligues", force: :cascade do |t|
    t.string "nom"
    t.boolean "reglement_defaut", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points_initial"
    t.integer "user_id"
    t.string "time_zone"
    t.string "discord"
    t.string "instagram"
    t.string "tiktok"
    t.string "twitch"
    t.string "youtube"
    t.string "twitter"
    t.index ["user_id"], name: "index_ligues_on_user_id"
  end

  create_table "parametre_setups", force: :cascade do |t|
    t.integer "setup_id", null: false
    t.integer "base_setup_id", null: false
    t.decimal "val_parametre"
    t.boolean "filled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_setup_id"], name: "index_parametre_setups_on_base_setup_id"
    t.index ["setup_id"], name: "index_parametre_setups_on_setup_id"
  end

  create_table "paris", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.integer "association_user_id", null: false
    t.decimal "montant"
    t.string "typepari"
    t.decimal "cote"
    t.string "resultat"
    t.decimal "solde"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["association_user_id"], name: "index_paris_on_association_user_id"
    t.index ["event_id"], name: "index_paris_on_event_id"
    t.index ["user_id"], name: "index_paris_on_user_id"
  end

  create_table "presences", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "association_user_id", null: false
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["association_user_id"], name: "index_presences_on_association_user_id"
    t.index ["event_id"], name: "index_presences_on_event_id"
  end

  create_table "problem_seconds", force: :cascade do |t|
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "problem_id", null: false
    t.index ["problem_id"], name: "index_problem_seconds_on_problem_id"
  end

  create_table "problems", force: :cascade do |t|
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string "status"
    t.integer "article_id", null: false
    t.integer "user_id", null: false
    t.string "stripe_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_purchases_on_article_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "rattachements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "ligue_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ligue_id"], name: "index_rattachements_on_ligue_id"
    t.index ["user_id"], name: "index_rattachements_on_user_id"
  end

  create_table "reglements", force: :cascade do |t|
    t.integer "ligue_id"
    t.string "num_article"
    t.string "titre_article"
    t.text "contenu_article"
    t.integer "penalite"
    t.string "penalite_temps"
    t.boolean "defaut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ligue_id"], name: "index_reglements_on_ligue_id"
  end

  create_table "resultats", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "association_user_id", null: false
    t.integer "equipe_id", null: false
    t.string "qualification"
    t.string "qualification_sprint"
    t.integer "course"
    t.boolean "dotd"
    t.boolean "mt"
    t.integer "score"
    t.boolean "dnf"
    t.boolean "dns"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["association_user_id"], name: "index_resultats_on_association_user_id"
    t.index ["equipe_id"], name: "index_resultats_on_equipe_id"
    t.index ["event_id"], name: "index_resultats_on_event_id"
  end

  create_table "rivalites", force: :cascade do |t|
    t.integer "division_id", null: false
    t.integer "pilote1_id", null: false
    t.integer "pilote2_id", null: false
    t.boolean "statut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_rivalites_on_division_id"
    t.index ["pilote1_id"], name: "index_rivalites_on_pilote1_id"
    t.index ["pilote2_id"], name: "index_rivalites_on_pilote2_id"
  end

  create_table "saisons", force: :cascade do |t|
    t.integer "ligue_id", null: false
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ligue_id"], name: "index_saisons_on_ligue_id"
  end

  create_table "setups", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "circuit_id"
    t.text "commentaires"
    t.index ["circuit_id"], name: "index_setups_on_circuit_id"
    t.index ["game_id"], name: "index_setups_on_game_id"
    t.index ["user_id"], name: "index_setups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visiteur"
    t.boolean "pilote"
    t.boolean "admin"
    t.string "nom"
    t.text "slogan"
    t.text "bio"
    t.string "controlleur_type"
    t.string "pilote_prefere"
    t.string "twitch"
    t.integer "action_count"
    t.integer "edit_profile_score"
    t.integer "paris_score"
    t.integer "dotds_score"
    t.integer "score_pilote"
    t.integer "solde_paris"
    t.string "stripe_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "association_admins", "ligues"
  add_foreign_key "association_admins", "users"
  add_foreign_key "association_users", "divisions"
  add_foreign_key "association_users", "equipes"
  add_foreign_key "association_users", "ligues"
  add_foreign_key "association_users", "rattachements"
  add_foreign_key "association_users", "users"
  add_foreign_key "base_setups", "categorie_parametres"
  add_foreign_key "base_setups", "games"
  add_foreign_key "bonus_paris", "users"
  add_foreign_key "categorie_parametres", "games"
  add_foreign_key "comportement_base_setups", "base_setups"
  add_foreign_key "comportement_base_setups", "comportements"
  add_foreign_key "correctifs", "base_setups"
  add_foreign_key "correctifs", "problem_seconds"
  add_foreign_key "correctifs", "problems"
  add_foreign_key "correctifs", "setups"
  add_foreign_key "divisions", "saisons"
  add_foreign_key "dois", "association_admins"
  add_foreign_key "dois", "association_users", column: "demandeur_id"
  add_foreign_key "dois", "association_users", column: "implique_id"
  add_foreign_key "dois", "events"
  add_foreign_key "dois", "reglements"
  add_foreign_key "dotds", "association_users"
  add_foreign_key "dotds", "events"
  add_foreign_key "dotds", "users"
  add_foreign_key "events", "circuits"
  add_foreign_key "events", "divisions"
  add_foreign_key "licences", "association_users"
  add_foreign_key "licences", "events"
  add_foreign_key "ligues", "users"
  add_foreign_key "parametre_setups", "base_setups"
  add_foreign_key "parametre_setups", "setups"
  add_foreign_key "paris", "association_users"
  add_foreign_key "paris", "events"
  add_foreign_key "paris", "users"
  add_foreign_key "presences", "association_users"
  add_foreign_key "presences", "events"
  add_foreign_key "problem_seconds", "problems"
  add_foreign_key "purchases", "articles"
  add_foreign_key "purchases", "users"
  add_foreign_key "rattachements", "ligues"
  add_foreign_key "rattachements", "users"
  add_foreign_key "reglements", "ligues"
  add_foreign_key "resultats", "association_users"
  add_foreign_key "resultats", "equipes"
  add_foreign_key "resultats", "events"
  add_foreign_key "rivalites", "association_users", column: "pilote1_id"
  add_foreign_key "rivalites", "association_users", column: "pilote2_id"
  add_foreign_key "rivalites", "divisions"
  add_foreign_key "saisons", "ligues"
  add_foreign_key "setups", "circuits"
  add_foreign_key "setups", "games"
  add_foreign_key "setups", "users"
end
