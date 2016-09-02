class ChangeUsersRepliesCount < ActiveRecord::Migration
  def change
    remove_column :articles, :replies_count
  end
end
