class MyChannelViewController < ApplicationController
  before_action :authenticate_user!
  def index
  	@username = current_user.username
  end
end
