class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.string :city
      t.string :company
      t.string :github
      t.string :twitter
      t.string :language, :default => 'zh-CN'
      t.timestamps null: false
    end
    change_column :users, :id, :string, :limit => 32
  end
end
