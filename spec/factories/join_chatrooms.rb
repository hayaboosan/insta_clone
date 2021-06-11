# == Schema Information
#
# Table name: join_chatrooms
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_join_chatrooms_on_chatroom_id              (chatroom_id)
#  index_join_chatrooms_on_user_id                  (user_id)
#  index_join_chatrooms_on_user_id_and_chatroom_id  (user_id,chatroom_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (chatroom_id => chatrooms.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :join_chatroom do
    user { nil }
    chatroom { nil }
  end
end
