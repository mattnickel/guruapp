class DashboardController < ApplicationController
  def index
  	@session = session[:user_id]
  	@username = User.find(@session).first_name

  	@training_module = TrainingModule.all
  end
end
