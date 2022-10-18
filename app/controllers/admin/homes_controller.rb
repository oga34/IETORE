class Admin::HomesController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin/layouts/application'
    def top
        @posts = Post.all.order(created_at: :desc)
    end
end
