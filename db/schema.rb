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

ActiveRecord::Schema[7.1].define(version: 2024_08_15_112351) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "archetypes", force: :cascade do |t|
    t.string "identifier"
    t.string "name"
    t.integer "priority"
    t.integer "generation"
    t.json "cards"
    t.string "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_archetypes_on_game_id"
    t.index ["identifier"], name: "index_archetypes_on_identifier", unique: true
  end

  create_table "decks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "game_id", null: false
    t.bigint "archetype_id", null: false
    t.boolean "active", default: false
    t.index ["archetype_id"], name: "index_decks_on_archetype_id"
    t.index ["game_id"], name: "index_decks_on_game_id"
    t.index ["user_id", "active"], name: "index_decks_on_user_id_and_active", unique: true, where: "(active IS TRUE)"
  end

  create_table "games", id: :string, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "deck_id", null: false
    t.json "cards"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_lists_on_deck_id"
  end

  create_table "match_games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "match_id", null: false
    t.string "result"
    t.boolean "started", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_games_on_match_id"
  end

  create_table "matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "list_id"
    t.uuid "deck_id"
    t.bigint "opponent_archetype_id", null: false
    t.bigint "archetype_id", null: false
    t.boolean "bo3"
    t.boolean "coinflip_won"
    t.string "remarks"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archetype_id"], name: "index_matches_on_archetype_id"
    t.index ["deck_id"], name: "index_matches_on_deck_id"
    t.index ["list_id"], name: "index_matches_on_list_id"
    t.index ["opponent_archetype_id"], name: "index_matches_on_opponent_archetype_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "archetypes", "games"
  add_foreign_key "decks", "archetypes"
  add_foreign_key "decks", "games"
  add_foreign_key "lists", "decks"
  add_foreign_key "match_games", "matches"
  add_foreign_key "matches", "archetypes"
  add_foreign_key "matches", "archetypes", column: "opponent_archetype_id"
  add_foreign_key "matches", "decks"
  add_foreign_key "matches", "lists"
end
