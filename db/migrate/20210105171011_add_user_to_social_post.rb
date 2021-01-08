class AddUserToSocialPost < ActiveRecord::Migration[6.0]
  def change
    add_reference :social_posts, :user, index:true
  end
end
