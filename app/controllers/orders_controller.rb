class OrdersController < ApplicationController
  before_filter :authenticate_request!
  protect_from_forgery unless: -> {request.format.json?}

  def pay
    params = JSON.parse(request.body.read)

    if params["type"] == "bank"
      pay_via_bank
    end

    nfc_device = NfcDevice.find_by(nfc_id: params["nfc_id"])
    order = nfc_device.order
    buyer = get_user_by_token(params["buyer_auth_token"])

    # Stripe charge mock
    # Implement a real one with Stripe connect
    charge = true

    if charge
      order.set_confirm
      order.save
      render json: {status: 'Order successfully paid!'}, status: :ok
    else
      order.set_failure
      order.save
      render json: {status: 'Order successfully paid!'}, status: :bad_request
    end
  end

  def create
    params = JSON.parse(request.body.read)

    order = Order.new(status: 'Pending', amount: params["amount"])
    nfc = NfcDevice.find_by(nfc_id: params["nfc_id"])
    nfc.order = order

    if order.save && nfc
      render json: {status: 'Order created!', order: order.as_json}, status: :ok
    else
      render json: { status: 'Failed to create order.' }
    end
  end

  private
  def get_user_by_token(token)
    User.find(JsonWebToken.decode(token)[0]['user_id']) # finds by decoded ID
  end

  def pay_via_bank

  end
end
