class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :catagory

  has_many :bids
  has_many :images

  def self.all_active
    Product.all.select(&:active)
  end

  def self.all_approved
    self.where(approved: true)
  end

  def self.pending
    self.where(approved: false)
  end

  def highest_bid
    bids.sort_by { |bid| bid.price.to_f }.reverse.first
  end

  def highest_bid_amount
    highest_bid ? highest_bid.price.to_f : 0
  end

  def active
    approved && expiration > DateTime.now
  end

  def finished
    expiration > DateTime.now
  end

  def won_by
    return nil unless has_winner?
    highest_bid.user
  end

  def has_winner?
    finished && bids.count > 0
  end
end