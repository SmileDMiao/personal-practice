class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :full_name
      t.string  :email
      t.string  :password_digest
      t.string  :auth_token
      t.string  :city
      t.string  :company
      t.string  :github
      t.string  :twitter
      t.integer :article_count,         default: 0,  null: false
      t.integer :comment_count,         default: 0,  null: false
      t.string  :favorite_article_ids,  default: [], array: true
      t.string  :following_ids,         default: [], array: true
      t.string  :follower_ids,          default: [], array: true
      t.string  :tagline
      t.string  :avatar_name
      t.string  :avatar
      t.string  :language,              :default => 'zh-CN'
      t.timestamps null: false
    end
    change_column :users, :id, :string, :limit => 32
  end
end
