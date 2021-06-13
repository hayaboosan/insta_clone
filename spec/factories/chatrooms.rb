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
FactoryBot.define do
  factory :chatroom do
    
  end
end
