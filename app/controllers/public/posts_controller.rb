class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  layout "public/layouts/application"

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @user = current_user
    @posts = @user.posts.published.reverse_order
    @genres = Genre.all
    if @post.save && @post.status == "published"
      redirect_to my_page_path(current_user), notice: "記録を作成しました！"
    elsif @post.save && @post.status == "draft"
      redirect_to my_page_path(current_user), notice: "下書きを保存しました"
    else
      render :new
    end
  end

  # #いいねしたユーザー一覧表示
  def favorited_user
    post = Post.find(params[:id])
    @favorites = post.favorites.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    # #投稿に紐づく全てのいいねの情報
    @favorites = @post.favorites
  end

  def draft
    @posts = current_user.posts.draft.reverse_order.page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to my_page_path(current_user), notice: "投稿内容を更新しました！"
    else
      render :edit, alert: "投稿内容を更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to my_page_path(current_user), notice: "投稿を削除しました"
  end

 private
   def post_params
     params.require(:post).permit(:genre_id, :user_id, :body, :count, :time, :status)
   end
end
