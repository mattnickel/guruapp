class UserMailer < ApplicationMailer
	
	default :from => 'limitlessminds@thinkbig-gofar.com'

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to the Limitless Minds App!')
	end

	def password_reset_email(user)
		@user = user
		mail(to: @user.email, subject: "Password Reset Instructions For Limitless Minds App")
	end

	
end
