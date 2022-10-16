class Public::PostCommentsController < ApplicationController
    before_action :authenticate_user!
    layout 'public/layouts/application'
    
  def create
    post = Post.find(post_comment_params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
    
  end
  
  def destroy
    PostComment.find(post_comment_params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

    
private
    def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id)
    end
end
