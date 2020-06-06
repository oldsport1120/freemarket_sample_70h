class ProductsController < ApplicationController

  def buy
  end
  
  def show
  end

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def new
    @product = Product.new
    @product.pictures.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      params[:pictures][:picture].each do |picture|
        @product.pictures.create(picture: picture)
      end
        redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:products_name, :descreption, :price, :brand, :product_condition, :shipment_fee, :shipping_place, :shipping_period, :user_id, :category_id,pictures_attributes: [:picture])
  end
end
