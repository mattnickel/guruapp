class ChangeFirstNameToUserName < ActiveRecord::Migration[6.0]
  def change
  	change_table :users do |t|
      t.rename :first_name, :username
      t.remove :last_name
    end
  end
end
