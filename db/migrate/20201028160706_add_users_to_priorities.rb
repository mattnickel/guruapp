class AddUsersToPriorities < ActiveRecord::Migration[6.0]
  def change
  	add_column :priorities, :user_id, :integer
  end
end
