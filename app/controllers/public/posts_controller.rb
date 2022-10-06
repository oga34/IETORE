class Public::PostsController < ApplicationController
    before_action :authenticate_user!
    layout 'public/layouts/application'
end
