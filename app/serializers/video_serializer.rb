class VideoSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 

   attributes :id, :title, :author, :description, :vimeo_id, :seconds, :url, :image, :file

   def image
   		url = object.image.service_url if object.image.attached?
   		return url.split("?")[0] if object.image.attached?
   end
   def file
   		url = url_for(object.video).to_str if object.video.attached?
   		return url
   end
end