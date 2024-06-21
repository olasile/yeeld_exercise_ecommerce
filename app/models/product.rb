class Product < ApplicationRecord
  validates :name, :price, presence: true

  after_create :create_in_stripe

  def create_in_stripe
    stripe_product = Stripe::Product.create({name: name})
    stripe_price = Stripe::Price.create({
                                   currency: 'usd',
                                   unit_amount: price_in_cents,
                                   product: stripe_product.id,
                                 })

    update(stripe_product_id: stripe_product.id, stripe_price_id: stripe_price.id)
  end

  def price_in_cents
    (price * 100).to_i
  end
end