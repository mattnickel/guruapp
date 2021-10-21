class ChangeTypeToAssessmentType < ActiveRecord::Migration[6.0]
  def change
    rename_column :assessments, :type, :assessment_type
  end
end
