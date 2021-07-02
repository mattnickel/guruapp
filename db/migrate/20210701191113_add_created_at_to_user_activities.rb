class AddCreatedAtToUserActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :user_activities, :created_at, :datetime
  end
end
