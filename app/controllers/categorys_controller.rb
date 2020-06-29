class CategorysController < ApplicationController

  def index
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
       @category_parent_array << parent.name
    end
  end
    

   # 以下全て、formatはjsonのみ
   # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

   # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
end

