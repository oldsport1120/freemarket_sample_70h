class ProductsController < ApplicationController

  def buy
    unless @product.soldout
      card = Card.where(user_id: current_user.id)
      if card.exists?
        @card     = Card.find_by(user_id: current_user.id)
        Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @default_card_information = Payjp::Customer.retrieve(@card.customer_id).cards.data[0]
      end
    else
      redirect_to product_path(@product)
    end
  end
  
  def show
  end
  
  def new
  end

  def pay
    @products = products.find(params[:id])
    Payjp.api_key = ENV['']
    charge = Payjp::Charge.create(
    amount: 1000,
    # amount: @products.price, <=最終的にこちらに差し替え
    card: params['payjp-token'],
    currency: 'jpy'
    )
  end
end
