class CreateNode < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :summary
      t.integer :section_id, :null => false
      t.integer :sort, :default => 0, :null => false
      t.integer :topics_count, :default => 0, :null => false
      t.timestamps null: false
    end
    change_column :nodes, :id, :string, :limit => 32
  end
end
