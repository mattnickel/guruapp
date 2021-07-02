class CreateUserActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :user_activities do |t|
    	t.integer :user_id
	  	t.integer :active_count
    end
  end
end
