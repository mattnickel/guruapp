class RenamePrioritesToPriorities < ActiveRecord::Migration[6.0]
  def change
  	rename_table :priorites, :priorities
  end
end
