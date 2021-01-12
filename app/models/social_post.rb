class SocialPost < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	has_many :post_bumps
end