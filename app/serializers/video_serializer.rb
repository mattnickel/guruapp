class VideoSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 

   attributes :id, :title, :author, :description, :vimeo_id, :seconds, :url, :image, :file

   def image
   		url = object.image.service_url if object.image.attached?
   		return url.split("?")[0]
   end
   def file
   		url = object.video.service_url if object.video.attached?
   		return url
   end
end