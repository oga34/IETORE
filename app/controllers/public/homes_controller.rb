class Public::HomesController < ApplicationController
    layout 'public/layouts/application'
    def top
        @posts = Post.all.order(created_at: :desc)
    end
end
