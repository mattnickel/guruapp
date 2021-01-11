class ApplicationController < ActionController::Base

	helper Webpacker::Helper
	acts_as_token_authentication_handler_for User
	before_action :configure_permitted_parameters, if: :devise_controller?, except: [:home]
	serialization_scope :current_user

protected

	def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

	def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
  end
	
	helper_method :current_user


end
