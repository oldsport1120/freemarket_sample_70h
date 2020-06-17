class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
      if comment.save
        redirect_to users_index_path, notice: "コメントが入力されました"
      else
        redirect_to users_index_path, notice: "コメントの入力ができませんでした"
      end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
