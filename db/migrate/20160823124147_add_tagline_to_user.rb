class AddTaglineToUser < ActiveRecord::Migration
  def change
    remove_column :users, :tagline
  	add_column :users, :tagline, :string, :limit => 30, :after => :twitter
  end
end
