class VideoSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 

   attributes :id, :title, :author, :description, :vimeo_id, :seconds, :url, :image, :file

   def image
   		url = object.image.service_url if object.image.attached?
   		return url.split("?")[0]
   end
   def file
   		# url = [host] + rails_blob_path(object.video, only_path: true) if object.video.attached?
   		# url = (object.video).signed_id() if object.video.attached?
   		url = url_for(object.video).to_str if object.video.attached?
   		return url
   end
end