class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name, null: false
      t.text    :description, null: false
      t.integer :stock, null: false
      t.integer :catagory_id, null: false
      t.integer :user_id, null: false
      t.boolean :live, null: false, default: false
      t.boolean :approved, null: false, default: false

      t.timestamps null: false
    end
  end
end
