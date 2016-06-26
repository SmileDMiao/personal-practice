class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, :limit => 20
      t.string :type, :limit => 20
      t.string :color, :limit => 20
      t.string :odor, :limit => 20
      t.text :description
      t.integer :number
      t.decimal :price, :precision => 5, :scale => 2
      t.string :country, :limit => 20
      t.string :rate_flag, :limit => 10, :default => "N"
      t.timestamps null: false
    end
    change_column :foods, :id, :string, :limit => 32
  end
end
