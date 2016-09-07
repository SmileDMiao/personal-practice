class CreateExceptionLogs < ActiveRecord::Migration
  def change
    create_table :exception_logs do |t|
      t.string :title
      t.string :body
      t.timestamps null: false
    end
    change_column :exception_logs, :id, :string, :limit => 32
  end
end
