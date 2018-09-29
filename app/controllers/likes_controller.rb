class LikesController < ApplicationController
  def create
    like = current_user.likes.create(review_id: params[:review_id])
    redirect_to review_path(like.review_id), notice: "#{like.review.user.name}さんのレビューにいいね！しました。"
  end

  def destroy
    like = current_user.likes.find_by(id: params[:id]).destroy
    redirect_to review_path(like.review_id), notice: "#{like.review.user.name}さんのレビューのいいね！を解除しました。"
  end
end
