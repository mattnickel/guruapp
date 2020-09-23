class ViewingsController < ApplicationController

  
  def update
    viewing = Viewing.find(params[:id])
    if viewing.update_attributes viewing_attributes
      respond_to do |format|
        format.html
        format.json { render json: viewing }
      end
    else
      respond_to do |format|
        format.html { redirect_to viewing }
        format.json { render errors: viewing.errors, status: 422 }
      end
    end
  end

private

  def viewing_attributes
    params.require(:viewing).permit(:length)
  end

end
end
