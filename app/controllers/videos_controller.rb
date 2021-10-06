class VideosController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only:[:edit, :update, :destroy]
  
  def index
  	@videos = Video.all
  end

  def show
    # @videos = Video.find(params[:id])
  end

  def new
  	# @videos = Video.new
    #@video = Video.new
    @video = current_user.videos.build
  end

  def edit
  	# @videos = Video.find(params[:id])
  end


  def create
	  @video = current_user.videos.build(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end


    # @training_module.user_id = current_user.id
	  # if @training_module.save
    # 	redirect_to @training_module
	  # else
	  #   render 'new'
	  # end

  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to video_url, notice: "video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @video = current_user.videps.find_by(id: params[:id])
    redirect_to videos_path, notice: "Not authorized" if @video.nil?
  end
 
  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :description, :author, :seconds, :image, :video)
    end
end
