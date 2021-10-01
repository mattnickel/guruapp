class CreateOfferedResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :offered_responses do |t|
      t.text :text
      t.integer :numeric_value

      t.timestamps
    end
  end
end
