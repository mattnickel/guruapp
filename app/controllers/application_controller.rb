class ApplicationController < ActionController::Base

	helper Webpacker::Helper
	acts_as_token_authentication_handler_for User
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:welcome]

protected


	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
	
	helper_method :current_user

	

end
