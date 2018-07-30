class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :sort, :default => 0, :null => false
      t.timestamps null: false
    end
    change_column :sections, :id, :string, :limit => 32
  end
end
