class Video < ApplicationRecord
	require "image_processing/vips"

	has_one_attached :image
	has_one_attached :social_image
	has_one_attached :video
	belongs_to :user
	has_many :module_videos
	has_many :training_modules, through: :module_videos
	has_and_belongs_to_many :categories
	# validate :image_format
	
	# def resize_image
 #      pipeline = ImageProcessing::Vips.source(social_image) # 600x800
	# 	result = pipeline.resize_to_fill!(300, 300)
	# 	Vips::Image.new_from_file(result.path).size #=> [400, 400]
 #  	end

 #  	def resize_social_image
 #      processed =  ImageProcessing::Vips.source(File.open(:image)).resize_to_limit!(300, 300)
 #     end
	# private

 #  def image_format
 #   return unless image.attached?
 #   if image.blob.content_type.start_with? 'image/'
 #     if image.blob.byte_size > 10.megabytes
 #       errors.add(:image, 'size needs to be less than 10MB')
 #       image.purge
 #     else
 #       resize_image
 #     end
 #    else
 #      image.purge
 #      errors.add(:image, 'needs to be an image')
 #    end
 #  end

 #  def social_image_format
 #   return unless social_image.attached?
 #   if image.blob.content_type.start_with? 'image/'
 #     if image.blob.byte_size > 10.megabytes
 #       errors.add(:image, 'size needs to be less than 10MB')
 #       image.purge
 #     else
 #       resize_social_image
 #     end
 #    else
 #      social_image.purge
 #      errors.add(:image, 'needs to be an image')
 #    end
 #  end
end
