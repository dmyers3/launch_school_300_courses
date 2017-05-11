class SessionsController < ApplicationController

  def new
  end
  
  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      flash[:notice] = "Welcome, you've logged in."
      session[:user_id] = user.id
      redirect_to posts_path
    else
      flash[:error] = "Incorrect Username and/or Password"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to posts_path
  end
end