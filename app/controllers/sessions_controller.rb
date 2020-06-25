class SessionsController < ApplicationController
	def new
	end

	def index
	end

	def create
	  user = User.find_by_email(params[:email])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect_to training_modules_path, notice: "Logged in!"
	  else
	    flash.now.alert = "Email or password is invalid"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to sessions_new_path, notice: "Logged out!"
	end
end
