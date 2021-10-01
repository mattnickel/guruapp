class CreateAssessments < ActiveRecord::Migration[6.0]
  def change
    create_table :assessments do |t|
      t.string :name
      t.string :type
      t.integer :assessment_question_id

      t.timestamps
    end
  end
end
