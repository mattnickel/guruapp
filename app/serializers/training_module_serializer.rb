class TrainingModuleSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 

   attributes :id, :title, :description, :cover_photo

   def cover_photo
   		url = object.cover_photo.service_url if object.cover_photo.attached?
   		return url.split("?")[0] if object.cover_photo.attached?
   end
   
end