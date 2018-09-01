class RenameCommntcontentColumnToComments < ActiveRecord::Migration[5.2]
    def change
      rename_column :comments, :comment_content, :content
    end
  end