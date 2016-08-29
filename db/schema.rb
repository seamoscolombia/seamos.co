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

ActiveRecord::Schema.define(version: 20160719200049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "OlimpiColombiaApp_athlete", id: :integer, default: -> { "nextval('\"OlimpiColombiaApp_sportman_id_seq\"'::regclass)" }, force: :cascade do |t|
    t.string  "first_name",  limit: 255,  null: false
    t.string  "last_name",   limit: 255,  null: false
    t.string  "birth_place", limit: 400,  null: false
    t.date    "birth_date",               null: false
    t.float   "weight",                   null: false
    t.float   "height",                   null: false
    t.integer "coach_id",                 null: false
    t.string  "img_url",     limit: 1000
    t.integer "sport_id",                 null: false
    t.index ["coach_id"], name: "OlimpiColombiaApp_sportman_ea814e95", using: :btree
    t.index ["sport_id"], name: "OlimpiColombiaApp_athlete_fc9fd9e6", using: :btree
  end

  create_table "OlimpiColombiaApp_coach", force: :cascade do |t|
    t.string "first_name", limit: 255, null: false
    t.string "last_name",  limit: 255, null: false
  end

  create_table "OlimpiColombiaApp_sport", force: :cascade do |t|
    t.string "name",    limit: 255,  null: false
    t.string "img_url", limit: 1000
  end

  create_table "OlimpiColombiaApp_sportevent", force: :cascade do |t|
    t.date    "date",                     null: false
    t.time    "time",                     null: false
    t.string  "sport_event", limit: 400,  null: false
    t.string  "result",      limit: 255
    t.string  "video",       limit: 1000
    t.integer "sport_id",                 null: false
    t.index ["sport_id"], name: "OlimpiColombiaApp_sportevent_fc9fd9e6", using: :btree
  end

  create_table "OlimpiColombiaApp_sportevent_athletes", force: :cascade do |t|
    t.integer "sportevent_id", null: false
    t.integer "athlete_id",    null: false
    t.index ["athlete_id"], name: "OlimpiColombiaApp_sportevent_athletes_975a0aa5", using: :btree
    t.index ["sportevent_id", "athlete_id"], name: "OlimpiColombiaApp_sportevent_athlet_sportevent_id_e57b13ec_uniq", unique: true, using: :btree
    t.index ["sportevent_id"], name: "OlimpiColombiaApp_sportevent_athletes_47e5639d", using: :btree
  end

  create_table "auth_group", force: :cascade do |t|
    t.string "name", limit: 80, null: false
    t.index "name varchar_pattern_ops", name: "auth_group_name_a6ea08ec_like", using: :btree
    t.index ["name"], name: "auth_group_name_key", unique: true, using: :btree
  end

  create_table "auth_group_permissions", force: :cascade do |t|
    t.integer "group_id",      null: false
    t.integer "permission_id", null: false
    t.index ["group_id", "permission_id"], name: "auth_group_permissions_group_id_0cd325b0_uniq", unique: true, using: :btree
    t.index ["group_id"], name: "auth_group_permissions_0e939a4f", using: :btree
    t.index ["permission_id"], name: "auth_group_permissions_8373b171", using: :btree
  end

  create_table "auth_permission", force: :cascade do |t|
    t.string  "name",            limit: 255, null: false
    t.integer "content_type_id",             null: false
    t.string  "codename",        limit: 100, null: false
    t.index ["content_type_id", "codename"], name: "auth_permission_content_type_id_01ab375a_uniq", unique: true, using: :btree
    t.index ["content_type_id"], name: "auth_permission_417f1b1c", using: :btree
  end

  create_table "auth_user", force: :cascade do |t|
    t.string   "password",     limit: 128, null: false
    t.datetime "last_login"
    t.boolean  "is_superuser",             null: false
    t.string   "username",     limit: 150, null: false
    t.string   "first_name",   limit: 30,  null: false
    t.string   "last_name",    limit: 30,  null: false
    t.string   "email",        limit: 254, null: false
    t.boolean  "is_staff",                 null: false
    t.boolean  "is_active",                null: false
    t.datetime "date_joined",              null: false
    t.index "username varchar_pattern_ops", name: "auth_user_username_6821ab7c_like", using: :btree
    t.index ["username"], name: "auth_user_username_key", unique: true, using: :btree
  end

  create_table "auth_user_groups", force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "auth_user_groups_0e939a4f", using: :btree
    t.index ["user_id", "group_id"], name: "auth_user_groups_user_id_94350c0c_uniq", unique: true, using: :btree
    t.index ["user_id"], name: "auth_user_groups_e8701ad4", using: :btree
  end

  create_table "auth_user_user_permissions", force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "auth_user_user_permissions_8373b171", using: :btree
    t.index ["user_id", "permission_id"], name: "auth_user_user_permissions_user_id_14a6b632_uniq", unique: true, using: :btree
    t.index ["user_id"], name: "auth_user_user_permissions_e8701ad4", using: :btree
  end

  create_table "departamentos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "django_admin_log", force: :cascade do |t|
    t.datetime "action_time",                 null: false
    t.text     "object_id"
    t.string   "object_repr",     limit: 200, null: false
    t.integer  "action_flag",     limit: 2,   null: false
    t.text     "change_message",              null: false
    t.integer  "content_type_id"
    t.integer  "user_id",                     null: false
    t.index ["content_type_id"], name: "django_admin_log_417f1b1c", using: :btree
    t.index ["user_id"], name: "django_admin_log_e8701ad4", using: :btree
  end

  create_table "django_content_type", force: :cascade do |t|
    t.string "app_label", limit: 100, null: false
    t.string "model",     limit: 100, null: false
    t.index ["app_label", "model"], name: "django_content_type_app_label_76bd3d3b_uniq", unique: true, using: :btree
  end

  create_table "django_migrations", force: :cascade do |t|
    t.string   "app",     limit: 255, null: false
    t.string   "name",    limit: 255, null: false
    t.datetime "applied",             null: false
  end

  create_table "django_session", primary_key: "session_key", id: :string, limit: 40, force: :cascade do |t|
    t.text     "session_data", null: false
    t.datetime "expire_date",  null: false
    t.index "session_key varchar_pattern_ops", name: "django_session_session_key_c0390e0f_like", using: :btree
    t.index ["expire_date"], name: "django_session_de54fa62", using: :btree
  end

  create_table "globales", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.string   "valor",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_globales_on_codigo", using: :btree
  end

  create_table "municipios", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["departamento_id"], name: "index_municipios_on_departamento_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_de_documentos", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.string   "nombres"
    t.integer  "tipo_de_documento_id"
    t.string   "numero_documento",     null: false
    t.date     "fecha_expedicion"
    t.integer  "rol_id"
    t.string   "uid",                  null: false
    t.boolean  "valido"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["numero_documento"], name: "index_usuarios_on_numero_documento", using: :btree
    t.index ["rol_id"], name: "index_usuarios_on_rol_id", using: :btree
    t.index ["tipo_de_documento_id"], name: "index_usuarios_on_tipo_de_documento_id", using: :btree
    t.index ["uid"], name: "index_usuarios_on_uid", unique: true, using: :btree
  end

  add_foreign_key "OlimpiColombiaApp_athlete", "\"OlimpiColombiaApp_coach\"", column: "coach_id", name: "OlimpiColombiaA_coach_id_4e64c365_fk_OlimpiColombiaApp_coach_id"
  add_foreign_key "OlimpiColombiaApp_athlete", "\"OlimpiColombiaApp_sport\"", column: "sport_id", name: "OlimpiColombiaA_sport_id_b7b26df1_fk_OlimpiColombiaApp_sport_id"
  add_foreign_key "OlimpiColombiaApp_sportevent", "\"OlimpiColombiaApp_sport\"", column: "sport_id", name: "OlimpiColombiaA_sport_id_204f4230_fk_OlimpiColombiaApp_sport_id"
  add_foreign_key "OlimpiColombiaApp_sportevent_athletes", "\"OlimpiColombiaApp_athlete\"", column: "athlete_id", name: "OlimpiColom_athlete_id_e432b4b1_fk_OlimpiColombiaApp_athlete_id"
  add_foreign_key "OlimpiColombiaApp_sportevent_athletes", "\"OlimpiColombiaApp_sportevent\"", column: "sportevent_id", name: "Olimp_sportevent_id_a038a84a_fk_OlimpiColombiaApp_sportevent_id"
  add_foreign_key "auth_group_permissions", "auth_group", column: "group_id", name: "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id"
  add_foreign_key "auth_group_permissions", "auth_permission", column: "permission_id", name: "auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id"
  add_foreign_key "auth_permission", "django_content_type", column: "content_type_id", name: "auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id"
  add_foreign_key "auth_user_groups", "auth_group", column: "group_id", name: "auth_user_groups_group_id_97559544_fk_auth_group_id"
  add_foreign_key "auth_user_groups", "auth_user", column: "user_id", name: "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id"
  add_foreign_key "auth_user_user_permissions", "auth_permission", column: "permission_id", name: "auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id"
  add_foreign_key "auth_user_user_permissions", "auth_user", column: "user_id", name: "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id"
  add_foreign_key "django_admin_log", "auth_user", column: "user_id", name: "django_admin_log_user_id_c564eba6_fk_auth_user_id"
  add_foreign_key "django_admin_log", "django_content_type", column: "content_type_id", name: "django_admin_content_type_id_c4bce8eb_fk_django_content_type_id"
  add_foreign_key "municipios", "departamentos"
  add_foreign_key "usuarios", "roles"
  add_foreign_key "usuarios", "tipo_de_documentos"
end
