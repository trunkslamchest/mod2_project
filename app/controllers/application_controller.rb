class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def not_authorized
    if @current_user == nil
      redirect_to login_path
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def record_not_found
		redirect_to @current_user
	end


end

