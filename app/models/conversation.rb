class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :converser, class_name: "User"
  has_many :messages

  def other_user(original_user)
    original_user == user ? converser : user
  end
end