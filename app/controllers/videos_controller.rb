class VideosController < ApplicationController
  # before_action :authenticate_user!
  # protect_from_forgery 
  #  with: :null_session, only: [:create]
  # # before_filter :authenticate_user!
  # before_action :verify_authenticity_token
  # skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user, only: [:create], raise: false
  #before_action :authenticate_user!, except: :create

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

  def create
    
   
    # @current_user ||= User.find_by(authentication_token: headers['Token'])
    # @authentication_token = current_user.authentication_token
    #getting actiondispatch issue with below code
	  #  video = Video.new(video_params)
    #hard-code params
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  

    # @training_module.user_id = current_user.id
	  # if @training_module.save
    # 	redirect_to @training_module
	  # else
	  #   render 'new'
  	# end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
   
    redirect_to video_path
  end
 
  private
   

      def video_params
        params.require(:video).permit(:description, :title, :video)
        # params.require(:video).permit(:title, :description, :author, :seconds, :image, :video)
        
      

      end

  end

 