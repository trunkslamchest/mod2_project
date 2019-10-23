class UsersController < ApplicationController

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
	redirect_to @user
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


end
