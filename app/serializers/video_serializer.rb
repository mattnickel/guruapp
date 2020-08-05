class VideoSerializer < ActiveModel::Serializer
   attributes :id, :title, :author, :description, :vimeo_id, :duration
end