class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  def now_read
    update_attribute(:read, true)
  end

  def display_read(index, current_user)
    index == conversation.messages.count - 1 && read && user == current_user
  end
end