class ProductsController < ApplicationController
  before_action :set_products,            only:[:show,:edit,:update,:buy]

  require "payjp"
  # before_action :set_card

  def buy
    @users = current_user
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    @card = current_user.card
    customer = Payjp::Customer.retrieve(@card.customer_id) 
    @card_info = customer.cards.retrieve(customer.default_card)
    @exp_month = @card_info.exp_month.to_s
    @exp_year = @card_info.exp_year.to_s.slice(2,3)
  end


  def pay
    @product = Product.find(params[:product_id])
    # すでに購入されていないか？
    if @product.buyer.present? 
      redirect_back(fallback_location: root_path) 
    elsif @card.blank?
      redirect_to controller: "cards", action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      # 請求を発行
      Payjp::Charge.create(
      amount: @products.price,
      customer: @card.customer_id,
      currency: 'jpy',
      )
      # 売り切れなので、productの情報をアップデートして売り切れにします。
      @product_purchaser= Product.find(params[:id])
      @product_purchaser.update(buyer_id: current_user.id)
      if @product.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: 'home', action: 'top', id: @product.id
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: 'products', action: 'show', id: @product.id
      end
    end
  end
  
  # 商品出品後のデータを反映させる Nonaka
  # コメントを反映させる Nonaka
  def show
    @product = Product.find(params[:id])
    # binding.pry
    @category =Category.where(ancestry: nil)
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
    # @grand_category = product.category 
  end

  def index
    @parents = Category.all.order("id ASC").limit(13)
    @products = Product.all
  end
  
  def new
    @product = Product.new
    @product.pictures.new
    # @category_parent_array = Category.where(ancestry: nil)
    if params[:parent_name]
      @category_parent_array = Category.where('ancestry = ?', "#{params[:parent_name]}")
      # binding.pry
    end
    # Category.where(ancestry: nil).each do |parent|
    #    @category_parent_array << parent.name
    # end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    # binding.pry
  end

   
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    if params[:product_pictures].present?
      @product = Product.new(product_params)
        respond_to do |format|
          if @product.save
              params[:product_pictures][:picture].each do |picture|
                @product.pictures.create(picture: picture, product_id: @product.id)
              end
            format.html{redirect_to root_path}
          else
            @product.pictures.build
            format.html{render action: 'new'}
          end
        end
    else
      redirect_to new_product_path, alert: "商品の出品ができませんでした"
    end
  end
  
  # destroy アクション nonaka
  def destroy
    product = Product.find(params[:id])
    if product.destroy
      redirect_to users_index_path, notice: "商品の削除が完了しました"
    else
      redirect_to users_index_path, alert: "商品の削除ができませんでした"
    end
  end

  def edit
  end

  def update
    if params[:product][:pictures_attributes] && @product.update(update_params)
        redirect_to root_path, notice: "商品の編集が完了しました"
    else
      redirect_to edit_product_path, alert: "商品の編集ができませんでした"
    end
  end

  # def buy
  #   @product = Product.find(params[:id])
  #   #@address = Product.where(id: current_user.id)
  # end

  private

  def product_params
    params.require(:product).permit(:products_name, :descreption, :price, :brand, :product_condition, :shipment_fee, :prefecture_id, :shipping_period, :category_id, :sale_status, pictures_attributes: [:picture]).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:product).permit(:products_name, :descreption, :price, :brand, :product_condition, :shipment_fee, :prefecture_id, :shipping_period, :category_id, :sale_status, pictures_attributes: [:picture, :id, :_destroy]).merge(user_id: current_user.id)
  end

  def set_products
    @product = Product.find(params[:id])
  end
  
  
  # def set_card
  #   @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  # end
end

