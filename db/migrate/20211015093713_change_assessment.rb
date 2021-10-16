class ChangeAssessment < ActiveRecord::Migration[6.0]
  def change
    remove_column :assessments, :assessment_question_id, :integer
    add_reference :assessments, :user, index:true, after: :name
    add_reference :assessments, :assessment_question, index:true, after: :name
  end
end
