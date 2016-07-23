class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.string :topic_id, null: false
      t.string :user_id, null: false
      t.integer   :likes_count ,        default: 0
      t.string    :action
      t.string    :target_type
      t.string    :target_id
      t.timestamps null: false
    end
    change_column :comments, :id, :string, :limit => 32
  end
end
