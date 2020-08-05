class RemoveDurationFromVideos < ActiveRecord::Migration[6.0]
  def change
    remove_column :videos, :duration
  end
end
