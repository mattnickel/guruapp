class PostBump < ApplicationRecord
	belongs_to :user
	belongs_to :social_post
end
