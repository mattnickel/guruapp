class ArticleController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only:[:edit, :update, :destroy]

      def index
         @articles = Article.all
         respond_to do | format |
          format.html # index.html.erb
          format.json { render json: @articles }
         end
      end
    
      def show
      end
  
      def new
         @article = current_user.articles.build
      end
  
      def edit

      end
    
      def update
        respond_to do |format|
          if @article.update(article_params)
            format.html { redirect_to @article, notice: "article was successfully updated." }
            format.json { render :show, status: :ok, location: @article }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
      end
  
      def create
        @article = current_user.articles.build(article_params)

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
        @article = Article.find(params[:id])
        @article.destroy
      end

      def correct_user
        @article = current_user.articles.find_by(id: params[:id])
        redirect_to article_path, notice: "Not authorized" if @article.nil?
      end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :excerpt, :content)
    end
  end