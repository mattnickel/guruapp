class VideosController < ApplicationController

  before_action :authorize
  
  def index
  	@videos = Video.all
  end

  def show
    @videos = Video.find(params[:id])
  end

  def new
  	@videos = Video.new
  end

  def edit
  	@videos = Video.find(params[:id])
  end

  def update
  	@videos = Video.find(params[:id])
      render 'edit'
    end
  end

  def create
	  @videos = Video.new(video_params)
    @training_module.user_id = current_user.id
	  if @training_module.save
    	redirect_to @training_module
	  else
	    render 'new'
	end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
   
    redirect_to video_path
  end


 
private
  def video_params
    params.require(:video).permit(:title, :description, :author, :seconds)
  end
end
