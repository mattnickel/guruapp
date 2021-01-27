class VideoSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 

   attributes :id, :title, :author, :description, :vimeo_id, :seconds, :url, :image, :social_image, :file

   
   def image
   		url = object.image.service_url if object.image.attached?
   		return url.split("?")[0] if object.image.attached?
   end
   def social_image
         url = object.social_image.service_url if object.social_image.attached?
         return url.split("?")[0] if object.social_image.attached?
   end
   def file
   		url = url_for(object.video).to_str if object.video.attached?
   		return url if object.video.attached?
   end
end