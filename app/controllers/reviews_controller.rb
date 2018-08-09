class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  PER = 2
  def index
    @review = Review.page(params[:page]).per(PER)
  end
  
  def new
    if user_signed_in?    
      if params[:back]
        @review = Review.new(review_params)
      else
        @review = Review.new
      end
    else
      redirect_to users_path, notice: "ログインしてね！"
    end
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    if @review.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to reviews_path, notice: "レビューを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def show
    @favorite = current_user.favorites.find_by(review_id: @review.id)
    @post_user = @review.user
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to reviews_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice:"ブログを削除しました！"
  end

  def confirm
    @review = Review.new(review_params)
    @review.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    render :new if @review.invalid?
  end
  
  private
  def review_params
    params.require(:review).permit(:title, :content, :user_id, :name, :image, :image_cache)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
