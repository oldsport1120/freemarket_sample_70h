class ProductsController < ApplicationController
  before_action :set_products,             only:[:show,:edit,:update]
  # before_action :show_all_instance,        only:[:show,:edit]
  # before_action :product_update_params,    only:[:update]

  def buy
  end
  
  # 商品出品後のデータを反映させる Nonaka
  # コメントを反映させる Nonaka
  def show
    @product = Product.find(params[:id])
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
  end

  def index
    @parents = Category.all.order("id ASC").limit(13)
    @products = Product.all
  end
  
  def new
    @product = Product.new
    @product.pictures.build()
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
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      redirect_to action: 'edit'
    end
    # if product_params[:pictures_attributes].nil?
    #   flash.now[:alert] = '更新できませんでした 【画像を１枚以上入れてください】'
    #   render :edit
    # else
    #   exit_ids = []
    #   product_params[:pictures_attributes].each do |a,b|
    #     exit_ids << product_params[:pictures_attributes].dig(:"#{a}",:id).to_i
    #   end
    #   ids = Picture.where(product_id: params[:id]).map{|picture| picture.id }
    #   delete__db = ids - exit_ids
    #   Picture.where(id:delete__db).destroy_all
    #   @product.touch
    #   if @product.update(product_params)
    #     redirect_to  root_path, notice: "商品情報の編集が完了しました"
    #   else
    #     flash.now[:alert] = '更新できませんでした'
    #     render :edit
    #   end
    # end
  end

  # def update_done
  #   @product_update = Product.order("updated_at DESC").first
  # end

  private

  def product_params
    params.require(:product).permit(:products_name, :descreption, :price, :brand, :product_condition, :shipment_fee, :shipping_place, :shipping_period, :category_id, :sale_status, pictures_attributes: [:picture, :id, :_destroy]).merge(user_id: current_user.id)
  end

  # def update_params
  #   params.require(:product).permit(:products_name, :descreption, :price, :brand, :product_condition, :shipment_fee, :shipping_place, :shipping_period, :category_id, :sale_status).merge(user_id: current_user.id)
  # end

  def set_products
    @product = Product.find(params[:id])
  end
  
  # def show_all_instance
  #   @user = User.find(@product.user_id)
  #   @pictures = Picture.where(product_id: params[:id])
  #   @pictures_first = Picture.where(product_id: params[:id]).first
  # end
end
