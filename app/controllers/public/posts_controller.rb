class Public::PostsController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :update, :destroy]
    layout 'public/layouts/application'
    
    def new
        @post = Post.new
        @genres = Genre.all
    end
    
    def create
      @post = Post.new(post_params)
      @genres = Genre.all
      if @post.save
        redirect_to my_page_path(current_user), notice: "記録を作成しました！"
      else
        render :new, alert: "記録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
    
    def show
      @post = Post.find(params[:id])
      @post_comment = PostComment.new
      ##投稿に紐づく全てのいいねの情報
      @favorites = @post.favorites
    end
    
    def draft
      @posts = current_user.posts.draft.reverse_order
    end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to my_page_path, notice: "記録を更新しました！"
    else
      render :edit, alert: "記録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy 
    redirect_back(fallback_location: root_path)
  end
  
 private
  def post_params
    params.require(:post).permit(:genre_id, :user_id, :body, :count, :time, :status)
  end
end
