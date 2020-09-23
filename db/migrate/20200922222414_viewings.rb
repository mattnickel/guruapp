class Viewings < ActiveRecord::Migration[6.0]
  def change
  	create_table :viewings do |t|
      t.integer :video_id
      t.integer :user_id
      t.integer :last_second_viewed
      t.integer :percent_viewed
      t.date :date_viewed
      t.string :day_viewed
      t.time :time_of_day

      t.timestamps
    end
  end
end
