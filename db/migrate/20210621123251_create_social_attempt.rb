class CreateSocialAttempt < ActiveRecord::Migration[6.0]
  def change
    create_table :social_attempts do |t|
      t.integer :user_id
      t.string :description
      t.datetime  :created_at, null: false
    end
  end
end
