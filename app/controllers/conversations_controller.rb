class ConversationsController < ApplicationController
  before_action :conversation_by_id, only: [:show]

  def show
    current_user.read_messages(@conversation)
    @message = Message.new
  end

  private

  def conversation_by_id
    @conversation = Conversation.find_by(id: params[:id])
  end
end