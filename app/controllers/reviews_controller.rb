class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]
  PER = 6
  def index
    @review = Review.where(draft: true).page(params[:page]).per(PER)
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
    @review = Review.find(params[:id])
    if current_user
      @favorite = current_user.favorites.find_by(review_id: @review.id)
      @like = current_user.likes.find_by(review_id: @review.id)
    end
    @post_user = @review.user
    @comment = Comment.new
    @comments = @review.comments
    @comments_number = @comments.count

    impressionist(@review, nil, :unique => [:session_hash])

    @page_views = @review.impressionist_count

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
    params.require(:review).permit(:title, :content, :user_id, :name, :image, :image_cache, :draft, :comment_content, :review_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def user_check
    unless Review.find(params[:id]).user_id == current_user.id
      redirect_to review_path(Review.find(params[:id]).id)
    end
  end

end
