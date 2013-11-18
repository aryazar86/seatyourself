class UsersController < ApplicationController
  before_filter :require_login, :only => :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def show
    if current_user.id.to_s == params[:id]
      @user = User.find(params[:id])
    else
      redirect_to user_path(current_user.id)
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
