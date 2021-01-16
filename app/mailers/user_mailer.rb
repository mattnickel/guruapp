class UserMailer < ApplicationMailer
	
	default :from => 'Limitless Minds App<limitlessminds@thinkbig-gofar.com>'

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to the Limitless Minds App!')
	end

	def password_reset_email(user, code)
		@user = user
		@code = code
		mail(to: @user.email, subject: "Password Reset Instructions For Limitless Minds App" )
	end

	def support_message(user, message)
		@user = user
		@message = message
		mail(to: "matt@thinkbig-gofar.com", subject: "New support message from Limitless Minds App")

	end

	
end
