class Video < ApplicationRecord


	has_one_attached :image
	has_one_attached :social_image
	has_one_attached :video
	has_many :viewings
	belongs_to :user
	has_many :module_videos
	has_many :training_modules, through: :module_videos
	has_and_belongs_to_many :categories
	has_one_attached :image_file

	
end
