class API::V1::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :ensure_params_exist, only: :create
    before_action :valid_email?
    
    def create

      @user = User.new user_params
      if @user.save
        if @user.valid_password?(user_params[:password])
          UserMailer.welcome_email(@user).deliver
          sign_in "user", @user
            render json: {
              messages: "Sign Up Successfully",
              is_success: true,
              data: @user,
              status: :ok
            }
        else
          render json: {
            error: "Password not valid",
            status: :bad_request
          }, status: 400
        end
      else
        render json: {
          error: "Email exists. Log in instead?",
          status: :bad_request
        }, status: 400
      end
    end
  
    private

    def user_params
      params.permit(:email, :password, :username)
    end
  
    def ensure_params_exist
      return if params[:email].present? && params[:password].present? && params[:username].present?
      render json: {
          messages: "Missing Params",
          is_success: false,
          data: {}
        }, status: :bad_request
    end

    def valid_email?
  
      # response = Truemail.valid?(params[:email], with: :smtp)
      # puts response
      # return unless response == false
      # render json: {error: params[:email]+" is an invalid email.",
      #     is_success: false,
      #     data: {}
      #   }, status: :bad_request
    end
    
  end