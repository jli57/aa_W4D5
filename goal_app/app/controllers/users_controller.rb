class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
