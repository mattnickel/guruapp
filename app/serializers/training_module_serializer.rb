class TrainingModuleSerializer < ActiveModel::Serializer
	 
	 include Rails.application.routes.url_helpers 

   attributes :id, :title, :description, :cover_photo, :videos

   has_many :videos, include: :all

   def cover_photo
   		url = object.cover_photo.service_url if object.cover_photo.attached?
   		return url.split("?")[0] if object.cover_photo.attached?
   end

   def videos
    videos = []
    videos = object.videos.each do |video|

    end
   return videos
   end
end