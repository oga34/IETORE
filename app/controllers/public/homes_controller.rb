class Public::HomesController < ApplicationController
  layout "public/layouts/application"

  # #トップページ
  def top
  end

  # #全てのユーザーの投稿一覧
  def index
    @genres = Genre.all
    @search = params[:search]
    if @search == nil
      @posts = Post.published.reverse_order.page(params[:page]).per(10)
    elsif @search == ""
      @posts = Post.published.reverse_order.page(params[:page]).per(10)
    else
      # 部分検索
      @posts = Post.joins(:genre).where("body LIKE(?) OR name LIKE(?)", "%#{@search}%",  "%#{@search}%").published.reverse_order.page(params[:page]).per(10)
    end
  end


  # #ゲストログイン
  def new_guest
    user = User.find_or_create_by(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲスト"
      user.first_name = "ゲスト"
      user.last_name = "ゲスト"
      user.first_name_kana = "ゲスト"
      user.last_name_kana = "ゲスト"
    end
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end
end
