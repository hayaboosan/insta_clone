class RemoveDirectMessageToCreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :chatrooms, :direct_message, :boolean
  end
end
