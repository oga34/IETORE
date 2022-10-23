class Public::UsersController < ApplicationController
    before_action :authenticate_user!
    layout 'public/layouts/application'
    
    def show
        @user = current_user
        @posts = current_user.posts
    end
    
    def edit
        @user = current_user
    end
  
    def update
        @user = current_user
        if @user.update(user_params)
            redirect_to my_page_path
        else
            render :edit
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
    
    private
    def user_params
      params.require(:user).permit( :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :nickname, :profile_image)
    end 
end
