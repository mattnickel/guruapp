class Video < ApplicationRecord
	has_one_attached :image
	has_one_attached :video
	belongs_to :user
	has_many :module_videos
	has_many :training_modules, through: :module_videos
	has_and_belongs_to_many :categories
	
	private
  
  def image_size
    errors.add :image, 'too big' if image.blob.byte_size > 400096
  end
end
