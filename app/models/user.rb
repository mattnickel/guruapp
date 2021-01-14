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

    def generate_password_token!
     self.reset_password_token = generate_token
     self.reset_password_sent_at = Time.now.utc
     save!
    end

    def password_token_valid?
     (self.reset_password_sent_at + 4.hours) > Time.now.utc
    end

    def reset_password!(password)
     self.reset_password_token = nil
     self.password = password
     save!
    end

    private

    def generate_token
     SecureRandom.hex(10)
    end
  	# has_many :comments
  # 	enum role: [:student, :teacher, :admin]
  #   after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :teacher
  # end
end
