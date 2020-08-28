class TrainingModule < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :module_videos
	has_many :videos, through: :module_videos
  has_one_attached :cover_photo
	validates :title, presence: true,
                    length: { minimum: 5 }
  belongs_to :user
                    
end
