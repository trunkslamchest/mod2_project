class SessionsController < ApplicationController
  skip_before_action :authorized?, only: [:new, :create, :destroy]

  def new
  end

  def create
    @user = User.find_by(user_name: params[:session][:user_name])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = ["Everything is WRONG!!!"]
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

end
