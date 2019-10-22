class UsersController < ApplicationController

def index
	all_users
end

def show
	find_user
end

private

def all_users
	@users = User.all
end

def find_user
	@user = User.find(params[:id])
end

end
