class DashboardController < ApplicationController
	before_action :authenticate_user!

  def index
  	@username = User.find(current_user.id).first_name

  	@training_module = TrainingModule.all.joins(:user)
  end
end
