class PostsController < ApplicationController
  
  before_action :ensure_author, only: [:edit, :update]
  before_action :ensure_priveledges, only: [:destroy]
  
  def new
    @subs = Sub.all
  end 
  
  def create
    debugger
    @post = Post.new(post_params)
    @post.author_id = current_user.id 
    if @post.save
      begin
        @post.sub_ids = post_sub_id_params
        redirect_to post_url(@post)
      rescue ActiveRecord::RecordNotFound => e
        @post.delete
        flash.now[:errors] = [e.message]
        render :new
      end
    else
      @subs = Sub.all
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
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end 
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
  
  def post_sub_id_params
    params[:post][:sub_ids]
    # params.require(:post).permit(:sub_ids)
  end
  
  def ensure_author
    @post = Post.find(params[:id])
    unless @post.author_id == current_user.id 
      flash[:errors] = ["You must be the post's author to edit this post"]
      redirect_to post_url(@post) 
    end
  end
  
  def ensure_priveledges
    @post = Post.includes(:subs).find(params[:id])
    unless @post.author_id == current_user.id #|| @post.sub.mod_id == current_user.id
      flash[:errors] = ["You lack sufficient priveledges to delete this post."]
      redirect_to post_url(@post) 
    end
  end
  
  
end