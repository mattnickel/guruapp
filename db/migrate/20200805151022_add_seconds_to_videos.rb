class AddSecondsToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :seconds, :integer
  end
end
