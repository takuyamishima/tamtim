class CreateHashtagTable < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.string :hashtag_name
    end
    add_index :hashtags, :hashtag_name, unique: true
  end
end
