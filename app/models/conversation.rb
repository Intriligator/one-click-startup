class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :converser, class_name: "User"
end