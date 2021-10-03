class AssessmentsController < ApplicationController

    def index
        assessments = Assessment.all
        respond_to do |format|
            format.html { render :index }
        end
    end

    def show
        @assessment = Assessment.find(params[:id])
    end

    def new
        @assessment = Assessment.new
    end

    def create
        @assessment = Assessment.new(assessment_params)

        respond_to do |format|
            if @assessment.save
              format.html { redirect_to @assessment, notice: "Assessment was successfully created." }
              format.json { render :show, status: :created, location: @assessment }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @assessment.errors, status: :unprocessable_entity }
            end
          end
    end



    private

    # Only allow a list of trusted parameters through.
    def assessment_params
      params.require(:assessment).permit(:name, :type)
    end
end
