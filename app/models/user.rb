class User < ApplicationRecord
  require "image_processing/mini_magick"

  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:standard, :premium, :coach, :employee, :admin]

  	# attr_accessible :email, :password, :password_confirmation
  	validates_uniqueness_of :email
  	has_many :training_modules
    has_many :videos
    has_many :social_posts
  	has_one_attached :avatar
    has_many :post_bumps
    has_many :support_messages
    has_many :bad_posts

   
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

    # def thumb
    #   return self.avatar.variant(resize:'100x100').processed  
    # end

    private
    

private

  # def avatar_format
  #  return unless avatar.attached?
  #  if avatar.blob.content_type.start_with? 'image/'
  #    if avatar.blob.byte_size > 10.megabytes
  #      errors.add(:avatar, 'size needs to be less than 10MB')
  #      avatar.purge
  #    else
  #      resize_image(avatar.blob.tempfile)
  #    end
  #   else
  #     avatar.purge
  #     errors.add(:avatar, 'needs to be an image')
  #   end
  # end

    def generate_token
     SecureRandom.hex(6)
    end


  	# has_many :comments
  # 	enum role: [:student, :teacher, :admin]
  #   after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :teacher
  # end
end
