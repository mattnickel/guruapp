class TrainingModulesController < ApplicationController

  def index
  end

  def show
    @training_module = TrainingModule.find(params[:id])
  end

  def new
  end

  def create
	  @training_module = TrainingModule.new(training_module_params)
	 
	  @training_module.save
	  redirect_to @training_module
	end
 
private
  def training_module_params
    params.require(:training_module).permit(:title, :text)
  end
end
