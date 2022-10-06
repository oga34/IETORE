class Public::PostCommentsController < ApplicationController
    before_action :authenticate_user!
    layout 'public/layouts/application'
end
