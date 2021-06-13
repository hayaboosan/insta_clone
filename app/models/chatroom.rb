# == Schema Information
#
# Table name: chatrooms
#
#  id             :bigint           not null, primary key
#  direct_message :boolean          default(FALSE), not null
#  name           :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :messages, dependent: :destroy

  scope :public_channels, -> { where(direct_message: false) }
  scope :direct_messages, -> { where(direct_message: true) }

  def self.chatroom_for_users(users, direct_message: false)
    user_ids = users.map(&:id).sort
    name = user_ids.join(':').to_s

    chatroom = if direct_message
                 direct_messages.find_by(name: name)
               else
                 find_by(name: name)
               end
    unless chatroom
      chatroom = new(name: name, direct_message: direct_message)
      chatroom.users = users
      chatroom.save
    end
    chatroom
  end
end
