class MyChannelViewController < ApplicationController
  before_action :authenticate_user!
  def index
  	@username = current_user.username
    @published_videos =  API::V1::MyChannelView.get_my_published_videos(current_user.id)
    #@video_list = published_videos.video_list
  end
end
