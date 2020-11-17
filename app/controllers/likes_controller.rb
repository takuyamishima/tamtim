class LikesController < ApplicationController
  after_action :create_notifications, only: [:create]

  def create
    @review = Review.find(params[:like][:review_id])
    unless @review.iine?(current_user)
      @review.iine(current_user)
      @review.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js { redirect_to request.referrer || root_url }
      end
    end
  end

  def destroy
    @review = Like.find(params[:id]).review
    if @review.iine?(current_user)
      @review.uniine(current_user)
      @review.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js { redirect_to request.referrer || root_url }
      end
    end
  end

  private
  def create_notifications
    return if @review.user.id == current_user.id
      Notification.create(user_id: @review.user.id,
        notified_by_id: current_user.id,
        review_id: @review.id,
        notified_type: 'いいね')
    end
  end
