class AddTrainingModuleIdToModuleVideos < ActiveRecord::Migration[6.0]
  def change
  	add_column :module_videos, :training_module_id, :integer
  	add_column :module_videos, :video_id, :integer
  end
end
