class CreateArticle < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :replies_count
      t.integer :likes_count
      t.timestamps null: false
    end
    change_column :articles, :id, :string, :limit => 32
  end
end
