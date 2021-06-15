class CreateStats < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.string :event_stat
	  t.string :description
      t.datetime :created_at, null: false
    end
  end
end
