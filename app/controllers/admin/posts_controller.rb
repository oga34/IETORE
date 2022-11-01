class Admin::PostsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin/layouts/application'
    
    def new
        @post = Post.new
        @genres = Genre.all
    end
    
    def create
      @post = Post.new(post_params)
      @genres = Genre.all
      if @post.save
        redirect_to posts_path
      else
        render :new
      end
    end
    
    
    def destroy
      post = Post.find(params[:id])
      post.destroy 
      redirect_to admin_root_path, notice: "投稿を削除しました"
    end
    
    def show
      @post = Post.find(params[:id])
      @post_comment = PostComment.new
      ##投稿に紐づく全てのいいねの情報
      @favorites = @post.favorites
    end
    
     ##いいねしたユーザー一覧表示
    def favorited_user
      post = Post.find(params[:id])
      @favorites = post.favorites
    end
    
    
    def draft
      @posts = current_user.posts.draft.reverse_order
    end
    
  
 private
  def post_params
    params.require(:post).permit(:genre_id, :user_id, :body, :count, :time)
  end
end
