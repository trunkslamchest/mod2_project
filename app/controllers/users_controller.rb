class UsersController < ApplicationController
	skip_before_action :authorized?, only: [:new, :create]
	before_action :set_user, only: [:index, :show, :edit, :update, :destroy]

	def index
		all_users
	end

	def show
		@current_user
	end

	def new
		@new_user = User.new
	end

	def edit
		find_user
	end

	def update
		find_user.update(user_params)
	end

	def create
		@new_user = User.create(user_params)
		if @new_user.valid?
			session[:user_id] = @new_user.id
			redirect_to @new_user
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

	def set_user
		if @current_user != find_user
			redirect_to @current_user
		end
	end

	def index_page
    if @current_user == nil
      root "sessions#new"
    else
      root "users#show"
    end
  end

end