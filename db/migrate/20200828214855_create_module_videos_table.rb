class CreateModuleVideosTable < ActiveRecord::Migration[6.0]
  def change
    create_table :module_videos do |t|
      t.belongs_to :training_modules
      t.belongs_to :videos
      t.timestamps
    end
  end
end
