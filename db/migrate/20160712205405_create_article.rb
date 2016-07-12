class CreateArticle < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :replies_count
      t.integer :likes_count
      t.timestamps null: false
    end
  end
end
