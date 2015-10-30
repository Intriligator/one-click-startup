class MessagesController < ApplicationController

  def new
    @converser = User.find_by(id: params[:converser_id])
    @message = Message.new
  end

  def create
    @conversation = find_conversation

    @message = Message.new(message_params)
    @message.assign_attributes(conversation_id: @conversation.id)
    if @message.save
      redirect_to conversation_path(@conversation)
    else
      flash[:warn] = "Unable to send message, please try again"
      redirect_to :back
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content)
  end

  def find_conversation
    conditions = { :user_id => params[:message][:user_id],
                   :converser_id => params[:message][:converser_id] }

    Conversation.where("user_id= ? AND converser_id= ?", params[:message][:user_id], params[:message][:converser_id]).first || Conversation.create(conditions)
  end

end