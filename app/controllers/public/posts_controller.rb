class Public::PostsController < ApplicationController
    before_action :authenticate_user!
    layout 'public/layouts/application'
    
    def new
        @post = Post.new
    end
    
    def create
    @post = Post.new(post_params)
        if @post.save
        redirect_to posts_path
        else
        render :new
        end
    end
  
    def index
    @posts = curennt_user.posts
    end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end
  
 private
  def post_params
    params.require(:post).permit(:genre_id)
  end
end
