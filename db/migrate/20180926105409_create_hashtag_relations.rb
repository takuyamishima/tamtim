class CreateHashtagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_relations do |t|
      t.integer :review_id
      t.integer :hashtag_id

      t.timestamps
    end
  end
end
