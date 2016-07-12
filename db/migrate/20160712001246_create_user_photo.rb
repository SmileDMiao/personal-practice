class CreateUserPhoto < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.string :user_id
      t.string :file_name
      t.timestamps null: false
    end
    change_column :user_photos, :id, :string, :limit => 32
  end
end
