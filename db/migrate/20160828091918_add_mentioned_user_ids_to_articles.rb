class AddMentionedUserIdsToArticles < ActiveRecord::Migration
  def change
    add_column :articles,  :mentioned_user_ids, :string, default: [], array: true
  end
end
