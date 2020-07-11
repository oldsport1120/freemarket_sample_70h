class ProductsController < ApplicationController

  def buy
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
    binding.pry
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
      redirect_to new_product_path
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
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:products_name, :descreption, :price, :brand, :product_condition, :shipment_fee, :shipping_place, :shipping_period, :category_id, :sale_status, pictures_attributes: [:picture]).merge(user_id: current_user.id)
  end
  
end