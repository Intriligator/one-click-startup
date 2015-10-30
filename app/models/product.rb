class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :catagory

  has_many :bids
  has_many :images

  def self.all_approved
    self.where(approved: true)
  end

  def highest_bid
    bids.order(price: :desc).first
  end
end