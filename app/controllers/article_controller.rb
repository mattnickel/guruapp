class ArticleController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :find_video, :only => [:show, :edit, :update, :destroy]
    
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
        @article = Video.new(article_params)
        # @article.content_type = 'article'
        @article.save
        # if @article.save
        #   render 'index'
        # else
        #   render 'new'
        # end
      end
  
      def destroy
        @article = Video.find(params[:id])
        @article.destroy
      end
  
  private
    def article_params
      params.permit(:title, :description, :author, :excerpt, :content)
    end
  end