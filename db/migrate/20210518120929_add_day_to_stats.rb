class AddDayToStats < ActiveRecord::Migration[6.0]
  def change
    add_column :stats, :day, :string
  end
end
