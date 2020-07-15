class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.string :send_user_id
      t.string :receive_user_id
      t.text :message
      t.timestamps
    end
  end
end
