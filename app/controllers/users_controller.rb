class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You are registered."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "You successfully updated your profile"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :time_zone)
    end
    
    def set_user
      @user = User.find_by(slug: params[:id])
    end
    
    def require_same_user
      if @user.id != session[:user_id]
        flash[:error] = "You do not have access to that page."
        redirect_to root_path
      end
    end
  
end