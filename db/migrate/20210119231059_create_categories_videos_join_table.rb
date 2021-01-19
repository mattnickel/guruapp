class CreateCategoriesVideosJoinTable < ActiveRecord::Migration[6.0]
  def change
  	create_join_table :categories, :videos do |t|
	    t.index :category_id
	    t.index :video_id
	  end
	end
end
