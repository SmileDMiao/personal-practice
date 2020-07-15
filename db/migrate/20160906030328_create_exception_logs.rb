class CreateExceptionLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :exception_logs, id: :uuid do |t|
      t.string :title
      t.string :body
      t.timestamps null: false
    end
  end
end
