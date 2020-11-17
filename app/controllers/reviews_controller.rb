class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]
  def index
    if params[:tag].present?
      @review = Review.tagged_with(params[:tag])
    elsif params[:category_name].present?
      @review = Review.where(category_name: params[:category_name])
    else
      @review = Review.all
      @review = @review.includes(:tags)
    end
    @categories = Category.all
    @comment = Comment.new
  end

  def new
    @category_name = Category.all
    if user_signed_in?
      if params[:back]
        @review = Review.new(review_params)
        @review.reviewtags.build
      else
        @review = Review.new
        @review.reviewtags.build
      end
    else
      redirect_to root_path, notice: "ログインしてね！"
    end
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    
    if @review.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to user_path(@review.user_id), notice: "レビューを作成しました！"
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
    @category_name = @review.category_name
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
    redirect_to user_path(current_user.id), notice:"レビューを削除しました！"
  end

  def confirm
    @review = Review.new(review_params)
    @review.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    
    render :new if @review.invalid?
  end

  private
  def review_params
    params.require(:review).permit(:title, :content, :user_id, :name, :image, { images: [] }, :image_cache, :draft, :comment_content, :review_id, :interest_list, :skill_list, :category_name, :image_url, :amazon_url, :asin)
  end


  def set_review
    @review = Review.find(params[:id])
    @category_name = Category.all
  end

  def user_check
    unless Review.find(params[:id]).user_id == current_user.id
      redirect_to review_path(Review.find(params[:id]).id)
    end
  end

end
