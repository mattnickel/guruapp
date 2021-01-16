class ChangeSupportToBeText < ActiveRecord::Migration[6.0]
  def change
  	change_column :support_messages, :message, :text
  end
end
