class CreateBlockedUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :blocked_users do |t|
    	 t.references :user
    	 t.integer :blocked_user_id
    end
  end
end
