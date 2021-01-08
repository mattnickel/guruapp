class SocialPostSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 
   require 'date'


   attributes :id, :time, :message, :image, :user_name, :user_tagline, :user_avatar
   has_one :image

  def image
 		url = object.image.service_url if object.image.attached?
 		return url.split("?")[0] if object.image.attached?
  end

  def user_name 
    name = object.user.first_name
    return name
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

end