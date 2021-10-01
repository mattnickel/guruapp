class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :text
      t.integer :offered_response_id

      t.timestamps
    end
  end
end
