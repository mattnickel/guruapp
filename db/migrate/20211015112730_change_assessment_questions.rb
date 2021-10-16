class ChangeAssessmentQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :assessment_questions, :assessment_id, :integer
    remove_column :assessment_questions, :question_id, :integer
    add_reference :assessment_questions, :assessment, index:true
    add_reference :assessment_questions, :question, index:true
  end
end
