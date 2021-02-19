class AddHideOnlyToBadPosts < ActiveRecord::Migration[6.0]
  def change
  	rename_column :bad_posts, :bump, :hide_only
  end
end
