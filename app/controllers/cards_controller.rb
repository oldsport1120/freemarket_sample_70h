class CardsController < ApplicationController

  before_action :authenticate_user!
  
  require "payjp"
  before_action :set_card


#   def index
#     # すでにクレジットカードが登録しているか？
#     if @card.present?
#       # 登録している場合,PAY.JPからカード情報を取得する
#       # PAY.JPの秘密鍵をセットする。
#       Payjp.api_key = ENV["sk_test_c190e707b548e5e4929eb812"]
#       # PAY.JPから顧客情報を取得する。
#       customer = Payjp::Customer.retrieve(@card.payjp_id)
#       # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
#       @card_info = customer.cards.retrieve(customer.default_card)
#       # クレジットカード情報から表示させたい情報を定義する。
#       # クレジットカードの画像を表示するために、カード会社を取得
#       @card_brand = @card_info.brand
#       # クレジットカードの有効期限を取得
#       @exp_month = @card_info.exp_month.to_s
#       @exp_year = @card_info.exp_year.to_s.slice(2,3)
#     end
#   end
#   def new
#     # @card = Card.new
#     @card = Card.where(user_id: current_user.id).first
#     redirect_to action: "index" if @card.present? 

#   end

#   def create
#     Payjp.api_key = ENV["sk_test_c190e707b548e5e4929eb812"]
#     if params['payjpToken'].blank?
#       render "new"
#     else
#       customer = Payjp::Customer.create(
#         description: 'test',
#         email: current_user.email,
#         card: params['payjpToken'],
#         metadata: {user_id: current_user.id}
#       )
#       @card = Card.new(user_id: current_user.id, payjp_id: customer.id)
#       if @card.save
#         if request.referer&.include?("/registrations/step5")
#           redirect_to controller: 'registrations', action: "step6"
#         else
#           redirect_to action: "index", notice:"支払い情報の登録が完了しました"
#         end
#       else
#         render 'new'
#       end
#     end
#   end

#   def show
#     card = current_user.card
#     if card.blank?
#       redirect_to action: "new"
#     else
#       Payjp.api_key = "sk_test_c190e707b548e5e4929eb812"
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       @customer_card = customer.cards.retrieve(card.card_id)
#     end
#   end

#   def destroy #PayjpとCardデータベースを削除します
#     Payjp.api_key = ENV["sk_test_c190e707b548e5e4929eb812"]
#     # PAY.JPの顧客情報を取得
#     customer = Payjp::Customer.retrieve(@card.payjp_id)
#     customer.delete # PAY.JPの顧客情報を削除
#       if @card.destroy # App上でもクレジットカードを削除
#         redirect_to action: "index", notice: "削除しました"
#       else
#         redirect_to action: "index", alert: "削除できませんでした"
#       end
#     end

#     private
#     def set_card
#       @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
#     end
#   end

#   def buy
#     @product = Product.find(params[:product_id])
#     # すでに購入されていないか？
#     if @product.buyer.present? 
#       redirect_back(fallback_location: root_path) 
#     elsif @card.blank?
#       # カード情報がなければ、買えないから戻す
#       redirect_to action: "new"
#       flash[:alert] = '購入にはクレジットカード登録が必要です'
#     else
#       # 購入者もいないし、クレジットカードもあるし、決済処理に移行
#       Payjp.api_key = ENV["sk_test_c190e707b548e5e4929eb812"]
#       # 請求を発行
#       Payjp::Charge.create(
#       amount: @product.price,
#       customer: @card.customer_id,
#       currency: 'jpy',
#       )
#       # 売り切れなので、productの情報をアップデートして売り切れにします。
#       if @product.update(buyer_id: current_user.id)
#         flash[:notice] = '購入しました。'
#         redirect_to controller: 'products', action: 'show', id: @product.id
#       else
#         flash[:alert] = '購入に失敗しました。'
#         redirect_to controller: 'products', action: 'show', id: @product.id
#       end
#     end
#   end
#   # end
# # end

  def new
    @card = Card.new
    card = Card.where(user_id: current_user.id)
    if card.exists?
      redirect_to card_path(card[0].id)
    end
  end

  def create
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    # customer = Payjp::Customer.create(
    #   card: params[:payjp-token],
    #   metadata: {user_id: current_user.id}
    # )
    # @card = Card.new(
    #   card_id: customer.default_card,
    #   customer_id: customer.id,
    #   user_id: current_user.id
    # )
    # @card.save
    token = Payjp::Token.create({
      card: {
        number:     params[:card][:card_number],
        cvc:        params[:card][:cvc],
        exp_month:  params[:card][:exp_month],
        exp_year:   params[:card][:exp_year]
      }},
      {'X-Payjp-Direct-Token-Generate': 'true'} 
    )
    if token.blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(card: token)
      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      card.save!
      if card.save!
        redirect_to card_path(card)
      else
        redirect_to new_card_path
      end
    end
  end

  def show
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "create"
    else
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
    end
  end
  def destroy     
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # PAY.JPの顧客情報を取得
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    customer.delete # PAY.JPの顧客情報を削除
    if @card.destroy # App上でもクレジットカードを削除
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  private
  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
