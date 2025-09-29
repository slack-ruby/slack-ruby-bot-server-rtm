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

ActiveRecord::Schema[8.0].define(version: 20_201_125_164_500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pg_catalog.plpgsql'

  create_table 'teams', force: :cascade do |t|
    t.string 'team_id'
    t.string 'name'
    t.boolean 'active', default: true
    t.string 'domain'
    t.string 'token'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'bot_user_id'
    t.string 'activated_user_id'
    t.string 'activated_user_access_token'
    t.string 'oauth_scope'
    t.string 'oauth_version', default: 'v1', null: false
  end
end
