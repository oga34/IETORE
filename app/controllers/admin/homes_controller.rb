class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  layout "admin/layouts/application"
  def top
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
end
