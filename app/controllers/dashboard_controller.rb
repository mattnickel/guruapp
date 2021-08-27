class DashboardController < ApplicationController
	before_action :authenticate_user!

  def index
  	@username = current_user.username

  	@training_module = TrainingModule.where(user:current_user)
	data = API::V1::Dashboard.get_stat
	video_data = API::V1::Dashboard.vid_stat
	@video_watched_count = data.video_watched_count
	@active_user_count = data.active_user_count
	@most_active_day_week = data.most_active_day
	@total_system_user = data.total_user_count
	@top_3_watched_videos = data.top_3_videos
	@most_watched_video = video_data.most_watched_video
	@most_recent_video = video_data.most_recent_video	
  end

end
