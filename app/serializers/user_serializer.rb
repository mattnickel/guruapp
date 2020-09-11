class UserSerializer < ActiveModel::Serializer
	include Rails.application.routes.url_helpers 
   
  attributes :id, :email, :first_name, :avatar, :description

   def avatar
   		url = object.avatar.service_url if object.avatar.attached?
   		return url.split("?")[0] if object.avatar.attached?
   end
end