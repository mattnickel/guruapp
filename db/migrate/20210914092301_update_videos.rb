class UpdateVideos < ActiveRecord::Migration[6.0]
    def change
        change_table :videos do |t|
            t.string :content_type
            t.string :excerpt
            t.string :content
        end
    end
end