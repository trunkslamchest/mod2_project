class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  skip_before_action :authorized, only: [:new, :create]


def index
	all_users
end

def show
	find_user
end


def new
	@user = User.new
end

def create
	@user = User.create(user_params)
	if @user.valid?
		session[:user_id] = @user.id
		redirect_to @user
	else
		flash[:errors] = 'Error'
		redirect_to new_user_path
	end
end


def destroy
	@current_user.destroy
	redirect_to login_path
end


private

def all_users
	@users = User.all
end

def find_user
	@user = User.find(params[:id])
end

def user_params
	params.required(:user).permit(:user_name, :password, :email_address)
end

def authorize_user
	if @user != @current_user
		redirect_to login_path
	end
end

def set_user
	@user = find_user
	if @user != @current_user
		redirect_to @current_user
	end
end

end

#
# def set_user
# 	@user = find_user
# 	if @user != @current_user
# 		redirect_to login_path
# 	elsif @current_user.nil?
# 		redirect_to login_path
# 	end
# end
