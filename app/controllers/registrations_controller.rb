class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    unless @user.valid?
      flash[:errors] = errors(@user)
      return render :new
    end

    redirect_to root_path, notice: "Sign up successfully"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
