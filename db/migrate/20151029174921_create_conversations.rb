class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_id, null: false
      t.integer :converser_id, null: false

      t.timestamps null: false
    end
  end
end
