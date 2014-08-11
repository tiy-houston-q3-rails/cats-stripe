class PurchasesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  respond_to :html, :js, only: [:create]

  def create
    @cat = Cat.find(params[:cat_id])


    Stripe.api_key = ENV["STRIPE_SECRET"]

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => @cat.price,
        :currency => "usd",
        :card => token,
        :description => @cat.name
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end

    @purchase = Purchase.new
    @purchase.price = @cat.price
    @purchase.cat = @cat
    @purchase.purchaser_name = params[:stripeEmail]
    @purchase.token = charge.id

    @purchase.save


    redirect_to receipt_path(token: @purchase.token)
  end
  #
  def receipt
    @purchase = Purchase.find_by token: params[:token]
  end


end
