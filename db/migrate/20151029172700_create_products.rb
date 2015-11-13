class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name, null: false
      t.string  :tagline, null: false, limit: 60
      t.string  :mission, null: false
      t.string  :website
      t.text    :value_prop, null: false
      t.text    :description, null: false
      t.integer :stock, null: false, default: 1
      t.integer :catagory_id, null: false
      t.integer :user_id, null: false
      t.boolean :approved, null: false, default: false
      t.boolean :paid, null:false, default: false
      t.datetime :expiration, null: false

      t.timestamps null: false
    end
  end
end
