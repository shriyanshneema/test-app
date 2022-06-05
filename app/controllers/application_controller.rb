class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pagy::Backend

  before_action :set_current_user

  def authenticate_user
    redirect_to new_session_path, alert: "You must be signed in" unless @current_user
  end

  private
  def set_current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end
end
