class AddUserToSupportMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :support_messages, :user, index: true
  end
end
