class Article < ApplicationRecord
	validates :title, length: {maximum: 100,
    too_long: "%{count} characters is the maximum allowed" }
	validates :excerpt, length: {maximum: 100,
    too_long: "%{count} characters is the maximum allowed" }
	validates :description, length: {maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }
    
	belongs_to :user
end