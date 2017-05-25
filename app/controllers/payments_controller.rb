require "stripe"

class PaymentsController < ApplicationController
  before_filter :authenticate_request!
  protect_from_forgery unless: -> {request.format.json?}

  def add_card
    Stripe.api_key = "sk_test_tmLq3ZHqTXFFnA60pMT2ebZj"

    params = load_params

    customer = Stripe::Customer.retrieve(@current_user.stripe_token)
    source = customer.sources.create(source: {object: "card", exp_month: params["card"]["exp_month"],
                            exp_year: params["card"]["exp_year"], number: params["card"]["number"]})

    if source
      render json: { status: 'Kortelė pridėta!' }, status: :ok
    else
      render json: { status: 'Kortelė nesėkmingai pridėta - pabandykite dar kartą'}
    end
  end
end
