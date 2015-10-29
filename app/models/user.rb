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
end