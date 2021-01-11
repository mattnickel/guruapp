class UserSerializer < ActiveModel::Serializer
	include Rails.application.routes.url_helpers 
	delegate :current_user, to: :scope
   
  attributes :id, :email, :authentication_token, :first_name, :avatar, :description

   def avatar
   		# rails_blob_path(object.avatar, only_path: true)
   		url = object.avatar.service_url if object.avatar.attached?
   		return url.split("?")[0] if object.avatar.attached?
   end
end