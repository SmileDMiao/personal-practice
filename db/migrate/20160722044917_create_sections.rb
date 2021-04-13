class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections, id: :uuid do |t|
      t.string :name
      t.integer :sort, default: 0, null: false
      t.timestamps null: false
    end
  end
end
