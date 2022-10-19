class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin/layouts/application'
    
    def index
        @users = User.page(params[:page])
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts.page(params[:page]).order(created_at: :desc)
    end

    def edit
        @user = User.find(params[:id])
    end
  
    def update
        user = User.find(params[:id])
        if user.update(user_params)
            redirect_to admin_user_path(user.id)
        else
        render :edit
        end
    end

private
  def user_params
    params.require(:user).permit(:firsr_name,:last_name,:first_name_kana,:last_name_kana, :nickname,:email,:is_deleted)
  end
end
