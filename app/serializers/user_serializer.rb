class UserSerializer < ActiveModel::Serializer
	include Rails.application.routes.url_helpers 
	delegate :current_user, to: :scope
   
  attributes :id, :email, :authentication_token, :username, :avatar, :description, :group
   def avatar
   		# rails_blob_path(object.avatar, only_path: true)
   		url = object.avatar.service_url if object.avatar.attached?
   		return url.split("?")[0] if object.avatar.attached?
   end

   def group
      if object.groups.exists?
   		return object.groups.first.name
      end
   end
end