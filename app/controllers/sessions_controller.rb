class SessionsController < ApplicationController

  def new

    render :new
  end

  def create
    @user = User.find_by username: params[:username]

    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user) 
    else
      flash.notice = "'" + params[:username] + "' : is a Wrong User Name !!" 

      redirect_to new_session_path
    end
  end

  def destroy

  end
end
