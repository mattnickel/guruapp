class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :group
	validates_uniqueness_of :user
end
