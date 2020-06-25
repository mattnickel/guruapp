class DashboardController < ApplicationController
  def index
  	@session = session[:user_id]
  	@username = User.find(@session).first_name
  end
end
