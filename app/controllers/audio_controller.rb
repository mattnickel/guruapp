class AudioController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only:[:edit, :update, :destroy]
  
  def index
      @audios = Video.all
      respond_to do | format |
      format.html # index.html.erb
      format.json { render json: @audios }
      end
  end

  def show
    @audio = Video.find(params[:id])
  end

  def new
      @audio = Video.new
  end

  def edit
      @audio = Video.find(params[:id])
  end

  def update
      @audio = Video.find(params[:id])
      render 'edit'
  end

  def create
    @audio = current_user.videos.build(audio_params)
    @audio.content_type = 'audio'

    respond_to do |format|
      if @audio.save
        format.html { redirect_to @audio, notice: "Audio was successfully created." }
        format.json { render :show, status: :created, location: @audio }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @audio = Video.find(params[:id])
    @audio.destroy
  end

  def correct_user
    @video = current_user.videos.find_by(id: params[:id])
    redirect_to videos_path, notice: "Not authorized" if @video.nil?
  end

private
  def set_video
    @video = Video.find(params[:id])
  end

  def audio_params
    params.require(:video).permit(:title, :description, :author, :seconds, :image, :social_image, :video)
  end
end