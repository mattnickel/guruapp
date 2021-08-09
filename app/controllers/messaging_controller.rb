class MessagingController < ApplicationController
  
  def index
   @users = User.all
  end
end
