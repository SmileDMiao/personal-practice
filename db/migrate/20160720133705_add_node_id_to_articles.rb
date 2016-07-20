class AddNodeIdToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :node_id, :string, :after => :user_id
  end
end
