class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.string :article_id, null: false
      t.string :user_id, null: false
      t.integer :likes_count ,        default: 0
      t.string :liked_user_ids, default: [], array: true
      t.integer :likes_count, default: 0
      t.string :mentioned_user_ids, default: [], array: true
      t.timestamps null: false
    end
    change_column :comments, :id, :string, :limit => 32
  end
end
