class DashboardController < ApplicationController
	before_action :authenticate_user!

  def index
  	@username = current_user.username

  	@training_module = TrainingModule.where(user:current_user)
  end
end
