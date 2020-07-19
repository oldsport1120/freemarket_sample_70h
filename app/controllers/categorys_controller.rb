class CategorysController < ApplicationController
  before_action :set_category, only: :show

  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @products = @category.set_products
    # @products = @products.where(category_id: nil).order("created_at DESC").page(params[:page]).per(9)
  end

   # 以下全て、formatはjsonのみ
   # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find("#{params[:parent_id]}").children
  end
 
   # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
def set_category
  @category = Category.find(params[:id])
  if @category.has_children?
    @category_links = @category.children
  else
    @category_links = @category.siblings
  end
end

end