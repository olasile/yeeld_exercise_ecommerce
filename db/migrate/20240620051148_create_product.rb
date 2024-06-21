class CreateProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, null: false
      t.string :stripe_product_id
      t.string :stripe_price_id

      t.timestamps
    end
  end
end
