class API::V1::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token
    # before_action :ensure_params_exist, only: :create
    # skip_before_filter :verify_authenticity_token, :only => :create
    # sign up
    def create
      @user = User.new user_params
      @user.save
      if @user.valid_password?(user_params[:password])
        sign_in "user", @user
          render json: {
            messages: "Sign Up Successfully",
            is_success: true,
            data: @user,
            status: :ok
          }
      end
    end
  
    private

    def user_params
      params.permit(:email, :password, :first_name)
    end
  
    def ensure_params_exist
      return if params[:user].present?
      render json: {
          messages: "Missing Params",
          is_success: false,
          data: {}
        }, status: :bad_request
    end
    
  end