class User < ApplicationRecord
		has_secure_password
  	# attr_accessible :email, :password, :password_confirmation
  	validates_uniqueness_of :email
  	has_many :training_modules
  	has_one_attached :avatar
  	# has_many :comments
  # 	enum role: [:student, :teacher, :admin]
  #   after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :teacher
  # end
end
