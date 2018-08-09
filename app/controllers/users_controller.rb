class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    if params[:back]
      @user = User.new
      @user.icon.retrieve_from_cache! params[:cache][:icon]
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "ユーザー削除したよ！"
  end

  def user_params
    params.require(:user).permit( :name, :icon )
  end
end
