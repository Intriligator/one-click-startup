class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :location, null: false
      t.text   :bio, null: false
      t.string :occupation, null: false
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end
  end
end
