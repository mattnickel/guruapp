class CreateGameScores < ActiveRecord::Migration[6.0]
  def change
    create_table :game_scores do |t|
      t.integer :user_id
      t.string :game_type
      t.integer :score
      t.timestamps
    end
  end
end
