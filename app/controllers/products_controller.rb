class ProductsController < ApplicationController

  def buy
  end
  
  # 商品出品後のデータを反映させる 実験中 Nonaka
  def show
    # @product = Product.find(1) 
    @product = Product.find(params[:id])
    # 仮データ投入
  end

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def new
    @product = Product.new
    @product.pictures.build
  end

  def create
    # binding.pry
    if params[:pictures].present?
      @product = Product.new(product_params)
      if @product.save
        params[:pictures][:picture].each do |picture|
          @product.pictures.create(picture: picture)
        end
          redirect_to root_path
      else
        redirect_to new_product_path
      end
    else
      redirect_to new_product_path
    end
  end
  
  # destroy 記述中nonaka
  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to root_path
  end


  private

  def product_params
    params.require(:product).permit(:products_name, :descreption, :price, :brand, :product_condition, :shipment_fee, :shipping_place, :shipping_period, :category_id, :sale_status, pictures_attributes: [:picture]).merge(user_id: current_user.id)
  end
end
