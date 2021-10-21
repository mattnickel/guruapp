class ChangeResponsesTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :responses, :user_id, :integer
    remove_column :responses, :question_id, :integer
    remove_column :responses, :offered_response_id, :integer
    remove_column :responses, :assessment_id, :integer
    add_reference :responses, :assessment, index:true
    add_reference :responses, :question, index:true
    add_reference :responses, :assessment_question, index:true
    add_reference :responses, :offered_response, index:true
    add_reference :responses, :user, index:true
  end
end
