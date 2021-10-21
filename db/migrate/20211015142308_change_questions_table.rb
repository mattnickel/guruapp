class ChangeQuestionsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :offered_response_id, :integer
    add_reference :questions, :offered_response, index:true
    add_reference :questions, :assessment_question, index:true
  end
end
