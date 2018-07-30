class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string    :name,      :limit => 20
      t.string    :category,  :limit => 20
      t.string    :color,     :limit => 20
      t.string    :odor,      :limit => 20
      t.text      :description
      t.integer   :number
      t.decimal   :price,     :precision => 5, :scale => 2
      t.string    :country,   :limit => 20
      t.timestamps null: false
    end
    change_column :foods, :id, :string, :limit => 32
  end
end
