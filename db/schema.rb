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

ActiveRecord::Schema.define(version: 2021_10_15_142308) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token"
    t.datetime "expires_at"
    t.integer "user_id"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_token"], name: "index_api_keys_on_access_token", unique: true
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "assessment_questions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "assessment_id"
    t.bigint "question_id"
    t.index ["assessment_id"], name: "index_assessment_questions_on_assessment_id"
    t.index ["question_id"], name: "index_assessment_questions_on_question_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.string "name"
    t.string "assessment_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "assessment_question_id"
    t.index ["assessment_question_id"], name: "index_assessments_on_assessment_question_id"
    t.index ["user_id"], name: "index_assessments_on_user_id"
  end

  create_table "bad_posts", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "hide_only"
    t.bigint "social_post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["social_post_id"], name: "index_bad_posts_on_social_post_id"
    t.index ["user_id"], name: "index_bad_posts_on_user_id"
  end

  create_table "blocked_users", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "blocked_user_id"
    t.index ["user_id"], name: "index_blocked_users_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_videos", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "video_id", null: false
    t.index ["category_id"], name: "index_categories_videos_on_category_id"
    t.index ["video_id"], name: "index_categories_videos_on_video_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "game_scores", force: :cascade do |t|
    t.integer "user_id"
    t.string "game_type"
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "joincode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "module_videos", force: :cascade do |t|
    t.bigint "training_modules_id"
    t.bigint "videos_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "training_module_id"
    t.integer "video_id"
    t.index ["training_modules_id"], name: "index_module_videos_on_training_modules_id"
    t.index ["videos_id"], name: "index_module_videos_on_videos_id"
  end

  create_table "offered_responses", force: :cascade do |t|
    t.text "text"
    t.integer "numeric_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id"
    t.index ["question_id"], name: "index_offered_responses_on_question_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "page_name"
    t.string "hero_title"
    t.text "hero_description"
    t.string "cta_text"
    t.string "cta_description"
    t.string "section_heading"
    t.string "section_p1"
    t.string "section_p2"
    t.string "section_p3"
    t.string "background_color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "post_bumps", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "bump"
    t.bigint "social_post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["social_post_id"], name: "index_post_bumps_on_social_post_id"
    t.index ["user_id"], name: "index_post_bumps_on_user_id"
  end

  create_table "priorities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "offered_response_id"
    t.bigint "assessment_question_id"
    t.index ["assessment_question_id"], name: "index_questions_on_assessment_question_id"
    t.index ["offered_response_id"], name: "index_questions_on_offered_response_id"
  end

  create_table "responses", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "assessment_id"
    t.bigint "question_id"
    t.bigint "assessment_question_id"
    t.bigint "offered_response_id"
    t.bigint "user_id"
    t.index ["assessment_id"], name: "index_responses_on_assessment_id"
    t.index ["assessment_question_id"], name: "index_responses_on_assessment_question_id"
    t.index ["offered_response_id"], name: "index_responses_on_offered_response_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "social_attempts", force: :cascade do |t|
    t.integer "user_id"
    t.string "description"
    t.datetime "created_at", null: false
  end

  create_table "social_posts", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_social_posts_on_group_id"
    t.index ["user_id"], name: "index_social_posts_on_user_id"
  end

  create_table "stats", force: :cascade do |t|
    t.string "event_stat"
    t.string "description"
    t.datetime "created_at", null: false
    t.string "day"
    t.integer "active_count"
  end

  create_table "support_messages", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_support_messages_on_user_id"
  end

  create_table "training_modules", id: :serial, force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_training_modules_on_user_id"
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer "user_id"
    t.integer "active_count"
    t.datetime "created_at"
  end

  create_table "user_activity_calculations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "active_count"
    t.datetime "created_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.integer "role"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "authentication_token", limit: 30
    t.string "description"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "author"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.integer "vimeo_id"
    t.integer "seconds"
    t.integer "user_id"
    t.string "content_type"
    t.string "excerpt"
    t.string "content"
    t.boolean "is_published"
  end

  create_table "viewings", force: :cascade do |t|
    t.integer "video_id"
    t.integer "user_id"
    t.integer "last_second_viewed"
    t.integer "percent_viewed"
    t.date "date_viewed"
    t.string "day_viewed"
    t.time "time_of_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weekly_stats", force: :cascade do |t|
    t.string "event_stat"
    t.string "description"
    t.datetime "created_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
