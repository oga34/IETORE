class Public::UsersController < ApplicationController
    before_action :authenticate_user!
    layout 'public/layouts/application'
    
    def show
        @user = current_user
    end
    
    def edit
    end
    
    private
    def user_params
      params.require(:user).permit( :first_name, :last_name, :first_name_kana, :last_name_kana, :email, :nickname)
    end 
end
