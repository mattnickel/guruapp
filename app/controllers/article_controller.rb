class ArticleController < ApplicationController
  before_action :set_video, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only:[:edit, :update, :destroy]
    
      def index
         @articles = Video.all
         respond_to do | format |
          format.html # index.html.erb
          format.json { render json: @articles }
         end
      end
    
      def show
        @article = Video.find(params[:id])
      end
  
      def new
         @article = Video.new
      end
  
      def edit
          @article = Video.find(params[:id])
      end
    
      def update
          @article = Video.find(params[:id])
          render 'edit'
      end
  
      def create
        @article = current_user.videos.build(article_params)
        @article.content_type = 'article'

        respond_to do |format|
          if @article.save
            format.html { redirect_to @article, notice: "Article was successfully created." }
            format.json { render :show, status: :created, location: @article }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
      end
  
      def destroy
        @article = Video.find(params[:id])
        @article.destroy
      end
  
  private
    def set_video
      @video = Video.find(params[:id])
    end

    def article_params
      params.permit(:title, :description, :author, :excerpt, :content)
    end
  end