class PostsController < ApplicationController
  
  before_action :ensure_author, only: [:edit, :update]
  before_action :ensure_priveledges, only: [:destroy]
  
  def new
    @sub = Sub.find(params[:sub_id])
  end 
  
  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.author_id = current_user.id 
    if @post.save
      redirect_to sub_post_url(@post.sub_id, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to sub_post_url(@post.sub_id, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end 
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
  
  def ensure_author
    @post = Post.find(params[:id])
    unless @post.author_id == current_user.id 
      flash[:errors] = ["You must be the post's author to edit this post"]
      redirect_to sub_post_url(@post.sub_id, @post) 
    end
  end
  
  def ensure_priveledges
    @post = Post.includes(:sub).find(params[:id])
    unless @post.author_id == current_user.id || @post.sub.mod_id == current_user.id
      flash[:errors] = ["You lack sufficient priveledges to delete this post."]
      redirect_to sub_post_url(@post.sub_id, @post) 
    end
  end
  
  
end