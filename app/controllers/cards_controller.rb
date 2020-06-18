class CardsController < ApplicationController

  before_action :authenticate_user!
  
  require "payjp"
  def new
    @card = Card.new
  end

  def create
    email = current_user.email
    Payjp.api_key = "sk_test_c190e707b548e5e4929eb812"
      customer = Payjp::Customer.create(description: 'test')
      customer.cards.create(card: params[:payjp_token])
    @card = Card.new(customer_token: customer&.id)
    redirect_to action: "new", alert: "カードの登録に失敗しました。" and return if @card.invalid?
    ## 保存に成功した場合
    @card.user_id = current_user.id
    @card.save
    redirect_to cards_path and return
  end

  def show
    card = current_user.card
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = "sk_test_c190e707b548e5e4929eb812"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
  end

  def destroy #PayjpとCardデータベースを削除します
    card = current_user.card
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = 'sk_test_c190e707b548e5e4929eb812'
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.destroy
     #ここでpay.jpの方を消している
      card.destroy
     #ここでテーブルにあるcardデータを消している
    end
  end

  def buy #クレジット購入

    if card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      @product = Product.find(params[:product_id])
      # 購入した際の情報を元に引っ張ってくる
      card = current_user.credit_card
      # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = "sk_test_c190e707b548e5e4929eb812"
      Payjp::Charge.create(
      amount: @product.price, #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
      # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      if @product.update(status: 1, buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: "products", action: 'show'
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: "products", action: 'show'
      end
    end
  end
end

