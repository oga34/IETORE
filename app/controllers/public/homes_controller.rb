class Public::HomesController < ApplicationController
    layout 'public/layouts/application'
    
    ##トップページ
    def top
    end
    
    ##全てのユーザーの投稿一覧
    def index
        @posts = Post.all.order(created_at: :desc)
    end
    
    def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64 
        user.nickname = "ゲスト"
        user.first_name = "ゲスト"
        user.last_name = "ゲスト"
        user.first_name_kana = "ゲスト"
        user.last_name_kana = "ゲスト"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end
end
