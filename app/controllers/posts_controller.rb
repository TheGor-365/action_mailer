class PostsController < ApplicationController
  include PostNotifier

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show; end
  def edit; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    @post.save ? (redirect_to post_url(@post)) : (render :new)
  end

  def update
    @post.update(post_params) ? (redirect_to post_url(@post)) : (render :edit)
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
