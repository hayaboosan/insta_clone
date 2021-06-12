# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chatroom < ApplicationRecord
  has_many :join_chatrooms, dependent: :destroy
  has_many :users, through: :join_chatrooms
  has_many :messages, dependent: :destroy

  def self.chatroom_for_users(users)
    user_ids = user.map(&:id).sort
    name = user_ids.join(':').to_s

    if chatroom == find_by(name: name)
      chatroom
    else
      chatroom = new(name: name)
      chatroom.users = users
      chatroom.save
      chatroom
    end
  end
end
