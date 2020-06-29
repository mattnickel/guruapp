class UsersController < ApplicationController
  
	def new
	  @user = User.new
	end

	def create
	  @user = User.new(user_params)
	  if @user.save
	    session[:user_id] = @user.id
	    redirect_to dashboard_path, notice: "Thank you for signing up!"
	  else
	    render "new"
	  end
	end
	def index
  	@user = current_user
  end

	def show
		@user = current_user
	end

	def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.avatar.attached?
  		@user.avatar.purge
  		@user.avatar.attach(params[:avatar])
  	else
  		@user.avatar.attach(params[:avatar])
  	end
    if @user.update(user_params)
      redirect_to dashboard_path, notice: "Your changes have been saved"
    else
      render 'edit'
    end
  end


	private 

	def user_params
    	params.require(:user).permit(:email, :first_name, :last_name, :password_digest, :password, :password_confirmation, :avatar)
  	end

end