class TrainingModulesController < ApplicationController

  before_action :authorize
  
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
    @training_module.cover_photo.attach(params[:cover_photo])
    if @training_module.update(training_module_params)
      redirect_to @training_module
    else
      render 'edit'
    end
  end

  def create
	  @training_module = TrainingModule.new(training_module_params)
    @training_module.user_id = current_user.id
	  if @training_module.save
    	redirect_to @training_module
	  else
	    render 'new'
	  end
	 
  end

  def destroy
  @training_module = TrainingModule.find(params[:id])
  @training_module.destroy
 
  redirect_to training_modules_path
end

 
private
  def training_module_params
    params.require(:training_module).permit(:title, :description, :user_id, :cover_photo)
  end
end
