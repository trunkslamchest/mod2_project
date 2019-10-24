class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :authorized?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # unless Rails.application.config.consider_all_requests_local
  #  rescue_from Exception, with: :record_not_found
  #  rescue_from ActionController::RoutingError, with: :record_not_found
  # end

  private

  def authorized?
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