class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :title
      t.text :body
      t.string :user_id
      t.string :node_id
      t.integer :comment_count, default: 0, null: false
      t.integer :likes_count, default: 0
      t.string :liked_user_ids, default: [], array: true
      t.string :mentioned_user_ids, default: [], array: true

      t.timestamps null: false
    end
  end
end
