class CardsController < ApplicationController

  before_action :authenticate_user!
  
  require "payjp"
  def new
    @card = Card.new
  end

  def create
    email = current_user.email
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.create(  ## 顧客の作成
      email: email,
      card: params[:card_token]
    )
    @card = Card.new(customer_token: customer&.id)
    redirect_to action: "new", alert: "カードの登録に失敗しました。" and return if @card.invalid?
    ## 保存に成功した場合
    @card.user_id = current_user.id
    @card.save
    redirect_to cards_path and return
  end
end
