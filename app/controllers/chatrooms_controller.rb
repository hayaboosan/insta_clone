class ChatroomsController < ApplicationController
  before_action :require_login, only: %i[show]

  def show
    @chatroom = current_user.chatrooms.find(params[:id])
  end
end
