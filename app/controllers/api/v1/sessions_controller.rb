class API::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :sign_in_params, only: :create
  before_action :load_user
  skip_before_action :verify_signed_out_user, only: :destroy
  protect_from_forgery unless: -> { request.format.json? }
  # sign in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      render json: @user, serializer: UserSerializer
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end
  def destroy
    if @user
      @user.authentication_token = nil
      @user.save!
        render json: {
            status: :ok
          }
    else
      render json: {
        messages: "Sign Out Failed - Bad email",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
    super
  end

  private
  def sign_in_params
    params.permit :email, :password, :format
  end

  def load_user 
    if @user = User.find_for_database_authentication(email: sign_in_params[:email])
      
      # return @better
    else
      render json: {
        messages: "Cannot get User",
        is_success: false,
        data: {}
      }, status: :failure
    end
  end
  
end
