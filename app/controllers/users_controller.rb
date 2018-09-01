class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :ensure_correct_user, only: [:destroy]

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
    @review  = current_user.reviews.build
    @feed_items = current_user.feed 
  end

  def edit
    @user = User.find(current_user.id)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "ユーザー削除したよ！"
  end
  
  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    @review  = current_user.reviews.build
    @feed_items = current_user.feed      
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit( :name, :icon )
  end

  def ensure_correct_user
    @user = User.find_by(id:params[:id])
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end  
end
