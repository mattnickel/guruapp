class TrainingModulesController < ApplicationController

  def index
  	@training_module = TrainingModule.all
  end

  def show
    @training_module = TrainingModule.find(params[:id])
  end

  def new
  	@training_module = TrainingModule.new
  end

  def edit
  	@training_module = TrainingModule.find(params[:id])
  end

  def update
  	@training_module = TrainingModule.find(params[:id])
    if @training_module.update(training_module_params)
      redirect_to @training_module
    else
      render 'edit'
    end
  end

  def create
	  @training_module = TrainingModule.new(training_module_params)

	  if @training_module.save
    	redirect_to @training_module
	  else
	    render 'new'
	  end
	 
  end
  
  def destroy
  @training_module = TrainingModule.find(params[:id])
  @article.destroy
 
  redirect_to articles_path
end

 
private
  def training_module_params
    params.require(:training_module).permit(:title, :text)
  end
end
