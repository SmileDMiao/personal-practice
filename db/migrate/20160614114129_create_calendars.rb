class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :id, :limit=>32, :null=>false
      t.string :name, :limit=> 30
      t.string :title,:limit=> 50
      t.datetime :start_time
      t.datetime :end_time
      t.string :color, :limit=>10
      t.string :all_day, :limit=>10, :default=>'Y'
      t.timestamps null: false
    end
  end
end
