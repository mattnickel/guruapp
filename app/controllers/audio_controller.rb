class AudioController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  before_action :find_video, :only => [:show, :edit, :update, :destroy]

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
      @audio = Video.new(audio_params)
      @audio.content_type = 'audio'
      # render :text => @audio.inspect
      if @audio.save
        render 'index'
      else
        render 'new'
      end
    end

    def destroy
      @audio = Video.find(params[:id])
      @audio.destroy
    end

private
  def audio_params
    params.require(:video).permit(:title, :description, :author, :seconds, :image, :social_image, :video)
  end
end