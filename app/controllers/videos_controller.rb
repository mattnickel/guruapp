class VideosController < ApplicationController

 
  
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

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  

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
    params.require(:video).permit(:title, :description, :author, :seconds, :image, :video)
  end
end
