class SocialPostSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 

   attributes :id, :time, :message, :image, :post_user_id, :username, :user_tagline, :user_avatar, :bump_count, :my_bump
   
   has_one :image

   has_one :comments, serializer: CommentsSerializer

  def image
 		url = object.image.service_url if object.image.attached?
 		return url.split("?")[0] if object.image.attached?
  end

  def post_user_id
    user_id = object.user.id
    return user_id
  end

  def username 
    user = object.user.username
    return user
  end

    def user_tagline 
      tag = object.user.description
      return tag
    end

    def user_avatar 
      avatar = object.user.avatar.service_url if object.user.avatar.attached?
      return avatar.split("?")[0] if object.user.avatar.attached?
    end

    def time
      time_stamp = object.created_at
      return time_stamp
    end

    def bump_count
      return object.post_bumps.where(bump: true).length
    end

    def my_bump
      # puts current_user.first_name
      return "true" if object.post_bumps.where(bump: true, user: scope.current_user).length > 0
    end

    def comments 
      return object.comments
    end

end