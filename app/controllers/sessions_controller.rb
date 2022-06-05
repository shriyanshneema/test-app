class SessionsController < ApplicationController
  skip_before_action :set_current_user, only: %i(create)
  before_action :set_user, only: %i(create)

  def create
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end

  private
  def set_user
    @user = User.find_by_email(params[:email])

    unless @user
      flash[:error] = "Unable to find user by give email"
      render :new
    end
  end
end
