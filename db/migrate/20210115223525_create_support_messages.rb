class CreateSupportMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :support_messages do |t|
      t.string :message
      t.timestamps
    end
  end
end
