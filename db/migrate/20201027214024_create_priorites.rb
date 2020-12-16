class CreatePriorites < ActiveRecord::Migration[6.0]
  def change
    create_table :priorites do |t|
      t.string :name
      t.string :description
      t.integer :position
      t.timestamps
    end
  end
end
