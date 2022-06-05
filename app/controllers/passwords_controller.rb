class PasswordsController < ApplicationController
  before_action :authenticate_user

  def update
    unless @current_user.authenticate(params[:current_password])
      flash[:error] = "You must provide a valid current password"
      return render :edit
    end

    if @current_user.update(password_params.except(:current_password))
      redirect_to user_path(@current_user), notice: "Password updated successfully"
    else
      flash[:error] = "Something went wrong please try again"
      render :edit
    end
  end

  private
  def password_params
    params.permit(:password, :current_password, :password_confirmation)
  end
end
