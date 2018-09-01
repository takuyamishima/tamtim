class AddColumnUsersProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile, :string, :limit=>200
  end
end
