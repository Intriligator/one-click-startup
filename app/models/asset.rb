class Asset < ActiveRecord::Base
  belongs_to :product
  has_one :images, as: :imageable
end