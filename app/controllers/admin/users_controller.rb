class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin/layouts/application'
    
    def index
        @users = User.page(params[:page]).per(10)
    end

    def show
        @user = User.find(params[:id])
        @search = params[:search] 
        if @search == nil
            @posts= @user.posts.published.reverse_order.page(params[:page]).per(10)
        elsif @search == ''
            @posts = @user.posts.published.reverse_order.page(params[:page]).per(10)
        else
             #部分検索
            @posts = @user.posts.published.reverse_order.joins(:genre).where("body LIKE(?) OR name LIKE(?)", "%#{@search}%",  "%#{@search}%").published.reverse_order.page(params[:page]).per(10)
        end
    end
    
    ##いいね一覧表示
    def favorites
        @user = User.find(params[:id])
        favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
        @posts = Post.published.reverse_order.find(favorites)
        @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
    end
    
    ##コメントした投稿一覧
    def commented
        @user = User.find(params[:id])
        commented = PostComment.where(user_id: @user.id).pluck(:post_id)
        @posts = Post.published.reverse_order.find(commented)
        @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
        @post_comment = PostComment.new
    end

    def edit
        @user = User.find(params[:id])
    end
  
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to admin_user_path(@user), notice: "編集内容を保存しました！"
        else
            render :edit, alert: "編集内容を保存できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        end
    end

private
  def user_params
    params.require(:user).permit(:firsr_name,:last_name,:first_name_kana,:last_name_kana, :nickname,:email,:is_deleted)
  end
end
