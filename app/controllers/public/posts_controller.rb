class Public::PostsController < ApplicationController
    before_action :authenticate_user!
    layout 'public/layouts/application'
    
    def new
        @post = Post.new
        @genres = Genre.all
    end
    
    def create
      @post = Post.new(post_params)
      @genres = Genre.all
      if @post.save
        redirect_to posts_path
      else
        render :new
      end
    end
    
    def show
      @post = Post.find(params[:id])
      @post_comment = PostComment.new
    end
  
    def index
    @posts = current_user.posts.all
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
    params.require(:post).permit(:genre_id, :user_id, :body, :count, :time)
  end
end
