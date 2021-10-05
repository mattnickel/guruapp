class AssessmentsController < ApplicationController
  before_action :set_assessment, only: %i[ show edit update destroy ]

  # GET /assessments or /assessments.json
  def index
    @assessments = Assessment.all
  end

  def show
  end

  def new
    @assessment = Assessment.new
  end


  def edit
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

  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html { redirect_to @assessment, notice: "Assessment was successfully updated." }
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @assessment.destroy
    respond_to do |format|
      format.html { redirect_to assessments_url, notice: "Assessment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    
    def assessment_params
      params.require(:assessment).permit(:name, :assessment_type)
    end
end
