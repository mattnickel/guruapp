class Group < ApplicationRecord
	has_many :memberships
    has_many :users, through: :memberships
    has_many :social_posts
    validates_uniqueness_of :joincode

end
