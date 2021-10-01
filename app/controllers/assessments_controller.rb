class AssessmentsController < ApplicationController

    def index
        assessments = Assessment.all
        respond_to do |format|
            format.html { render :index }
        end
    end


end
