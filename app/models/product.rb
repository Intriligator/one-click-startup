class Product < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :catagory

  has_many :bids
  has_many :images
  has_many :views
  has_many :assets
  has_many :socials

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

  def winning_bid
    return nil unless finished
    highest_bid
  end

  def highest_bid_amount
    highest_bid ? highest_bid.price.to_f : 0
  end

  def active
    approved && expiration > DateTime.now
  end

  def finished
    expiration < DateTime.now
  end

  def won_by
    return nil unless has_winner?
    highest_bid.user
  end

  def has_winner?
    finished && bids.count > 0
  end

  def price_to_s
    return "0.00" unless bids.count > 0
    highest_bid.price_to_s
  end

  def expiration_to_s
    return "Expired" if finished
    "Expires in #{distance_of_time_in_words(DateTime.now, expiration)}"
  end
end