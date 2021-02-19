class SocialPost < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	has_many :post_bumps
	has_many :bad_posts
end
