class ChangeOfferedResponses < ActiveRecord::Migration[6.0]
  def change
    add_reference :offered_responses, :question, index:true
  end
end
