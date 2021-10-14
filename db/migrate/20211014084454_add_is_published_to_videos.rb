class AddIsPublishedToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :is_published, :boolean
  end
end
