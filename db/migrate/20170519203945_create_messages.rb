class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :send_user_id
      t.string :receive_user_id
      t.text :message
      t.timestamps
    end
    change_column :messages, :id, :string, :limit => 32
  end
end
