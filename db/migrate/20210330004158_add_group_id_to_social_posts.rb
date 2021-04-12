class AddGroupIdToSocialPosts < ActiveRecord::Migration[6.0]
  def change
  	add_reference :social_posts, :group, index: true
  end
end
