class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.text    :content, null: false
      t.boolean :read, null: false, default: false

      t.timestamps null: false
    end
  end
end
