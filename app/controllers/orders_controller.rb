class OrdersController < ApplicationController
  before_action :set_product, only: [:new_complete]
  before_action :set_order, only: [:complete]

  def index
    @orders = Order.all
  end

  def new_complete
    @payment_intent = Stripe::PaymentIntent.create(
      amount: @product.price_in_cents,
      currency: 'usd'
    )

    @order = Order.create(product: @product, stripe_payment_intent_id: @payment_intent.id)
  end

  def complete
    @order.complete!
    redirect_to orders_path, flash: { success: 'Order successfully completed.' }
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end