class Video < ApplicationRecord
	has_one_attached :image
	has_one_attached :video
	
	validate :image_size
	
	private
  
  def image_size
    errors.add :image, 'too big' if image.blob.byte_size > 4096
  end
end
