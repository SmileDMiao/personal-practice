class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes, id: :uuid do |t|
      t.string :name
      t.string :summary
      t.string :section_id, limit: 32, null: false
      t.integer :sort, default: 0, null: false
      t.integer :topics_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
