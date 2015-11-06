class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def valid_bid?
    valid? && highest_bid?
  end

  def highest_bid?
    price > (product.highest_bid_amount)
  end

  def price_in_cents
    (price * 100).to_i
  end

  def price_to_s
    "%.2f" % price
  end
end