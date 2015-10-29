class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :catagory

  has_many :bids
end