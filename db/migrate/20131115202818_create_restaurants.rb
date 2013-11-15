class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :neighbourhood
      t.integer :category_id

      t.timestamps
    end
  end
end
