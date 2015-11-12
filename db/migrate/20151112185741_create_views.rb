class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :user_id
      t.integer :product_id, null: false

      t.timestamps null: false
    end
  end
end
