class AddUpdateAtToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :update_at, :datetime
  end
end
