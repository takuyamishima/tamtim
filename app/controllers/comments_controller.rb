class CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id]) #①
    @comment = @review.comments.build(comment_params) #②
    @comment.user_id = current_user.id #③
    @comment_number = Comment.count
    if @comment.save
      render :index #④
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id]) #⑤
    if @comment.destroy
      render :index #⑥
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :review_id, :user_id)
    end

end
