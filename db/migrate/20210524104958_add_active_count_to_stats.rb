class AddActiveCountToStats < ActiveRecord::Migration[6.0]
  def change
    add_column :stats, :active_count, :integer
  end
end
