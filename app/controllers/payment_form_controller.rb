class PaymentFormController < ApplicationController
  def index
    @payment_intent = Stripe::PaymentIntent.create(
      amount: 1000,
      currency: 'usd'
    )
  end
end