class CreateComments < ActiveRecord::Migration[5.2]
    def change
      create_table :comments do |t|
        t.text "content"
        t.integer "review_id"
        t.integer "user_id"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.timestamps
      end
    end
  end