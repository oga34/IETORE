class Public::UsersController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    layout 'public/layouts/application'
    
    def show
        @user = User.find(params[:id])
        @posts = @user.posts.published.reverse_order
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
  
  ##いいね一覧表示
  def favorites
      @user =current_user
      favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
      @posts = Post.find(favorites)
      @post_comment = PostComment.new
  end
    
    private
    def user_params
      params.require(:user).permit( :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :nickname, :profile_image)
    end 
end
