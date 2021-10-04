class Question < ApplicationRecord
    # has_many :offered_responses
end


# class QuestionsController < ApplicationController

#     def index
#         questions = Question.all
#         respond_to do |format|
#             format.html { render :index }
#         end
#     end

#     def show
#         @question = Question.find(params[:id])
#     end

#     def new
#         @question = Question.new
#     end

#     def create
#         @question = Question.new(question_params)

#         respond_to do |format|
#             if @question.save
#               format.html { redirect_to @question, notice: "Question was successfully created." }
#               format.json { render :show, status: :created, location: @question }
#             else
#               format.html { render :new, status: :unprocessable_entity }
#               format.json { render json: @question.errors, status: :unprocessable_entity }
#             end
#           end
#     end



#     private

#     # Only allow a list of trusted parameters through.
#     def question_params
#       params.require(:question).permit(:name, :assessment_type)
#     end
# end