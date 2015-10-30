class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def valid_bid?
    valid? && highest_bid?
  end

  def highest_bid?
    price > (product.highest_bid_amount)
  end
end