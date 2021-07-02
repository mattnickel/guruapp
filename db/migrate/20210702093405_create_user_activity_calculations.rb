class CreateUserActivityCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_activity_calculations do |t|
      t.integer :user_id
      t.integer :active_count
      t.datetime  :created_at, null: false
    end
  end
end
