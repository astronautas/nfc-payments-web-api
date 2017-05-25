require "stripe"

class UsersController < ApplicationController
  before_filter :authenticate_request!, :except => [:create, :login]

  protect_from_forgery unless: -> { request.format.json? }

  def create
    Stripe.api_key = "sk_test_tmLq3ZHqTXFFnA60pMT2ebZj"

    user = User.new(user_params)

    if user.valid?
      customer = Stripe::Customer.create(:email => user.email)
      user.stripe_token = customer.id
    end

    if user.save
      render json: {status: 'Naudotojas užregistruotas!'}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def login
    params = JSON.parse(request.body.read)
    user = User.find_by(email: params["user"]["email"].to_s.downcase)

    if user && user.authenticate(params["user"]["password"])
      auth_token = JsonWebToken.encode({user_id: user.id})
      render json: {auth_token: auth_token, type: user.group }, status: :ok
    else
      render json: {error: 'Neteisingas el. paštas / slaptažodis'}, status: :unauthorized
    end
  end

  def pass
    render json: { msg: "Auth successful", data: @current_user[:email] }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :group)
  end
end
