class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :message
      t.timestamp
    end
    change_column :tips, :id, :string, :limit => 32
  end
end
