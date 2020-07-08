class CardsController < ApplicationController

  # before_action :authenticate_user!
  
  require "payjp"
  before_action :set_card


  def new
    @card = Card.new
    card = Card.where(user_id: current_user.id)
    if card.exists?
      redirect_to cards_path(card[0].id)
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if params['payjp_token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(card: params[:payjp_token])

      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if card.save
        redirect_to cards_path(card)
      else
        redirect_to new_card_path
      end
    end
  end

  def show
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card_info = customer.cards.retrieve(customer.default_card)
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3)
    end
  end
  def destroy     
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    # PAY.JPの顧客情報を取得
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete # PAY.JPの顧客情報を削除
    if @card.destroy # App上でもクレジットカードを削除
      redirect_to action: "show", notice: "削除しました"
    else
      redirect_to action: "show", alert: "削除できませんでした"
    end
  end

  def pay
    if @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      # 請求を発行
      Payjp::Charge.create(
      amount: 1000,
      customer: @card.customer_id,
      currency: 'jpy',
      )
 
      redirect_to root_path, notice: "購入しました"

    end
  end

  private
  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
