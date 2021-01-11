class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  	# attr_accessible :email, :password, :password_confirmation
  	validates_uniqueness_of :email
  	has_many :training_modules
    has_many :videos
    has_many :social_posts
  	has_one_attached :avatar
    has_many :post_bumps
    # validates_attachment :avatar, presence: true
    # do_not_validate_attachment_file_type :avatar
    
    acts_as_token_authenticatable
  	# has_many :comments
  # 	enum role: [:student, :teacher, :admin]
  #   after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :teacher
  # end
end
