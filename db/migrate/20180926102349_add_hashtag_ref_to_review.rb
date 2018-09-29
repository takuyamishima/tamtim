class AddHashtagRefToReview < ActiveRecord::Migration[5.2]
  def change
    add_reference :hashtags, :review, index: true
  end
end
