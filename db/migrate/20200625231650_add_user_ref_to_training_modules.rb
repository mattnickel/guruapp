class AddUserRefToTrainingModules < ActiveRecord::Migration[6.0]
  def change
    add_reference :training_modules, :user
  end
end
