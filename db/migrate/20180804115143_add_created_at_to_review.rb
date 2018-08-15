class AddCreatedAtToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :created_at, :datetime
  end
end
