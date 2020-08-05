class VideoSerializer < ActiveModel::Serializer
   attributes :id, :title, :author, :description, :vimeo_id, :seconds
end