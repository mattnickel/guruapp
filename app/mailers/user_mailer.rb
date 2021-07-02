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

	def bad_content_email(id)
		@post_id = id
		mail(to: "matt@thinkbig-gofar.com", subject: "Objectionable social post reported in the Limitless Minds App")
	end

	def report_message(subject, message)
		@subject = subject
		@message = message
<<<<<<< HEAD
		
		mail(to: "naomi@topoflineinc.com", subject: subject)
		#limitlessminds@thinkbig-gofar.com
		
=======
		mail(to: "reybatacjr@gmail.com", subject: subject)
>>>>>>> 45cb39d076df8e74cac364d708c1d700c5c837bc

	end
	
end
