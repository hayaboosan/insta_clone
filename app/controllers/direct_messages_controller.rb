class DirectMessagesController < ApplicationController
  before_action :require_login

  def show
    users = [current_user, User.find(params[:id])]
    @chatroom = Chatroom.chatroom_for_users(users, direct_message: true)
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
    redirect_to chatroom_path(@chatroom)
  end
end
