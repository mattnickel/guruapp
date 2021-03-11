class ChangeCommentTable < ActiveRecord::Migration[6.0]
  def change
  	change_table :comments do |t|
  		t.remove :commenter
  		t.references :user
  		t.string :commentable_type
  		t.integer :commentable_id
  	end
  end
end
