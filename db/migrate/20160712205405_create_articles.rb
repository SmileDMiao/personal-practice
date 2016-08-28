class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :title
      t.text    :body
      t.integer :replies_count
      t.integer :likes_count
      t.string  :user_id
      t.string  :node_id
      t.integer :comment_count,      default: 0,  null: false
      t.integer :likes_count,        default: 0
      t.string  :liked_user_ids,     default: [], array: true
      t.string  :mentioned_user_ids, default: [], array: true
      t.timestamps null: false
    end
    change_column :articles, :id, :string, :limit => 32
  end
end
