class API::V1::SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  # sign in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        data: {user: @user},
        status: :ok
      }
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  private
  def sign_in_params
    puts params
    params.permit :email, :password
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    if @user
      return @user
    else
      render json: {
        messages: "Cannot get User",
        is_success: false,
        data: {}
      }, status: :failure
    end
  end
end

# module API
#   module V1
#     class Sessions < Grape::API
#       # include API::V1::Defaults

#       resource :sessions do
#         desc "Creates and returns access tokens if valid login"
#         params do
#           requires :login, type: String, desc: "Email address"
#           requires :password, type: String, desc: "Password"
#         end
#         post :login do
#           @user = User.find_by_email(params[:login].downcase)
#         end

#         if @user && @user.authenticate(params[:password])
#           key = ApiKey.create(user_id: user.id)
#           {token: key.access_token}

          
#         end

#         desc "Returns pong if logged in correctly"
#         params do
#           requires :token, type: String, desc: "Access token."
#         end
#         get :ping do
#           authenticate!
#           { message: "pong" }
#         end
#       end
#     end
#   end
# end
# end