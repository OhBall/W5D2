class SubsController < ApplicationController
  
  before_action :ensure_mod, only: [:edit, :update]
  before_action :ensure_logged_in, except: [:index, :show]
  
  def new
  end
  
  
  def create
    @sub = Sub.new(sub_params)
    @sub.mod_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def show
    @sub = Sub.find(params[:id])
  end
  
  def edit
    @sub = Sub.find(params[:id])
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end
  
    
  private
  
  def ensure_mod
    @sub = Sub.find(params[:id])
    unless @sub.mod_id == current_user.id
      flash[:errors] = ["You are not the moderator of this page."]
      redirect_to sub_url(@sub)
    end
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  
  
  
  
end