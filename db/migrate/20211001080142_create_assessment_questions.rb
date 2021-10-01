class CreateAssessmentQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_questions do |t|
      t.integer :assessment_id
      t.integer :question_id

      t.timestamps
    end
  end
end
