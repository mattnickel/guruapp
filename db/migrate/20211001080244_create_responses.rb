class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :assessment_id
      t.integer :question_id
      t.integer :offered_response_id
      t.text :text

      t.timestamps
    end
  end
end
