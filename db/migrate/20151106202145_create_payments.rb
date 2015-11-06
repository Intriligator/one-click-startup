class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer  :user_id, null: false
      t.integer  :buyer_id, null: false
      t.decimal  :price, null: false
      t.datetime :hold_date, null: false

      t.timestamps null: false
    end
  end
end
