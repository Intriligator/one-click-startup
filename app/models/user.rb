class User < ActiveRecord::Base
  has_secure_password

  has_many :products
  has_many :messages
  has_many :bids
  has_many :notifications

  has_many :conversations
  has_many :conversers, through: :conversations
  has_many :inverse_conversations, class_name: "Conversation", foreign_key: "converser_id"
  has_many :inverse_conversers, through: :inverse_conversations, source: :user

  def name
    "#{first_name} #{last_name}"
  end

  def pending_products
    products.where(approved: false)
  end

  def all_conversations
    conversations + inverse_conversations
  end

  def read_messages(conversation)
    conversation.messages.each { |message| message.now_read unless message.user == self }
  end
end