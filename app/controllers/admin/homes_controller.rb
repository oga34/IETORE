class Admin::HomesController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin/layouts/application'
    def top
        @genres = Genre.all
        @search = params[:search] 
        if @search == nil
            @posts= Post.published.reverse_order
        elsif @search == ''
            @posts = Post.published.reverse_order
        else
             #部分検索
             @posts = Post.joins(:genre).where("body LIKE(?) OR name LIKE(?)", "%#{@search}%",  "%#{@search}%").published.reverse_order
        end
    end
end
