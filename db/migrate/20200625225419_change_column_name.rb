class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :training_modules, :text, :description
  end
end
