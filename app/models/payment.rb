class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :buyer, class_name: "User"
end