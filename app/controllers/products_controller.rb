class ProductsController < ApplicationController
  def buy
  end
  
  def show
  end
  
  def new
    @product = Product.new
    @product.pictures.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :description, :price, :brand, :product_conditon, :shipment_fee, :shipping_place, :shipping_period, :user_id, :category_id,pictures_attributes: [:picture])
  end
end
