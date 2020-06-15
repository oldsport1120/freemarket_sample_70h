class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    # redirect_to "/products/#{product_comments_path.id}" 
    # redirect_to product_comments_path(comment_params)
    # redirect_to product_comments_path(comment_params)
    # redirect_to product_path
    # redirect_to user_url(id: @user.id)
    # redirect_to product_comments_path(id: product_comments_path.id)
    # redirect_to product_comments_path(comment_params)
    # redirect_back
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
