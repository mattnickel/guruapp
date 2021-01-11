class CreatePostBumps < ActiveRecord::Migration[6.0]
  def change
    create_table :post_bumps do |t|
      t.references :user
      t.boolean :bump
      t.references :social_post

      t.timestamps
    end
  end
end
