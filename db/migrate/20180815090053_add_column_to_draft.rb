class AddColumnToDraft < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :draft, :boolean
  end
end
