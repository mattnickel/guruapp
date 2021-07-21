class DashboardController < ApplicationController
	before_action :authenticate_user!

  def index
  	@username = current_user.username

  	@training_module = TrainingModule.where(user:current_user)
	data = API::V1::Dashboard.get_stat

	@video_watched_count = data.video_watched_count
  end
end
