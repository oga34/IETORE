class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  layout "public/layouts/application"

  def show
    @user = User.find(params[:id])
    @search = params[:search]
    if @search == nil
      @posts = @user.posts.published.reverse_order.page(params[:page]).per(10)
    elsif @search == ""
      @posts = @user.posts.published.reverse_order.page(params[:page]).per(10)
    else
      # 部分検索
      @posts = @user.posts.published.reverse_order.joins(:genre).where("body LIKE(?) OR name LIKE(?)", "%#{@search}%",  "%#{@search}%").published.reverse_order.page(params[:page]).per(10)
    end

    @published_posts = @user.posts.published
    @time = @published_posts.all.sum(:time)
    @count = @published_posts.all.sum(:count)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_path(current_user), notice: "編集内容を保存しました！"
    else
      render :edit, alert: "編集内容を保存できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
  end

  def unsubcribe
  end

  def withdraw
    @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  # #いいね一覧表示
  def favorites
    @user = current_user
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.published.reverse_order.find(favorites)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
    @post_comment = PostComment.new
  end


  # #コメントした投稿一覧
  def commented
    @user = current_user
    commented = PostComment.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.published.reverse_order.find(commented)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
    @post_comment = PostComment.new
  end

    private
      def user_params
        params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :nickname, :profile_image)
      end
end
