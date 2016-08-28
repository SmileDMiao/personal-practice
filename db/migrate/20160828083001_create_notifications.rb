class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string     :user_id,            null: false
      t.string     :actor_id
      t.string     :notify_type,        null: false
      t.string     :target_type
      t.string     :target_id
      t.string     :second_target_type
      t.string     :second_target_id
      t.datetime   :read_at
      t.timestamps null: false
    end
    change_column :notifications, :id, :string, :limit => 32
  end
end
