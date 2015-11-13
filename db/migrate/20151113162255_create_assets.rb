class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name, null: false
      t.string :description
      t.string :url

      t.timestamps null: false
    end
  end
end
