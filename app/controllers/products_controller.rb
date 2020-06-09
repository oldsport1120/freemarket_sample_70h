class ProductsController < ApplicationController

  def buy
  end
  
  def show
  end
  
  def new
  end

  def pay
    @products = products.find(params[:id])
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
    amount: 1000,
    # amount: @products.price, <=最終的にこちらに差し替え
    card: params['payjp-token'],
    currency: 'jpy'
    )
  end
end
