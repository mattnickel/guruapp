class SocialPost < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	belongs_to :group, optional: true
	has_many :post_bumps
	has_many :bad_posts
	has_many :comments, as: :commentable 

end
