class RemoveTrainingModuleFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :comments, :training_module, null: false, foreign_key: true
  end
end
