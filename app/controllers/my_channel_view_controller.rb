class MyChannelViewController < ApplicationController
  before_action :authenticate_user!
  def index
  	@username = current_user.username
    published_videos =  API::V1::MyChannelView.get_my_published_videos(current_user.id)
    @my_published_videos = published_videos.video_list
    unpublished_videos =  API::V1::MyChannelView.get_my_unpublished_videos(current_user.id)
    @my_unpublished_videos = unpublished_videos.video_list
  end
end
