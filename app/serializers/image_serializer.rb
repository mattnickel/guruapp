class ImageSerializer < ActiveModel::Serializer
	include Rails.application.routes.url_helpers 
	delegate :current_user, to: :scope
   
  attributes :avatar

   def avatar
   		# rails_blob_path(object.avatar, only_path: true)
   		url = object.avatar.service_url if object.avatar.attached?
   		return url.split("?")[0] if object.avatar.attached?
   end
end