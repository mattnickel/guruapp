class ChangeOfferedResponses < ActiveRecord::Migration[6.0]
  def change
    add_reference :offered_responses, :question, index:true
    add_reference :offered_responses, :assessment_question, index:true
  end
end
