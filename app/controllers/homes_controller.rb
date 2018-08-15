class HomesController < ApplicationController
  def index
    @users = User.all
    @review = Review.all
  end
end
