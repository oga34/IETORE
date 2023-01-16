class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  layout "public/layouts/application"

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    user = post_comment.user
    if user == current_user
      post_comment.destroy
      redirect_to post_path(params[:post_id])
    else
      redirect_to root_path
    end
  end


private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id)
  end
end
