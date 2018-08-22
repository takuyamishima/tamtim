module ReviewsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_reviews_path
    elsif action_name == 'edit'
      review_path
    end
  end
end
