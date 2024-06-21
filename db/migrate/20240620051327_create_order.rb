class CreateOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :stripe_payment_intent_id
      t.belongs_to :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
