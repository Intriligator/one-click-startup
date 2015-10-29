class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :catagory

  has_many :bids

  def self.all_approved
    self.where(approved: true)
  end
end