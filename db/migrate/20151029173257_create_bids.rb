class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :user_id, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
