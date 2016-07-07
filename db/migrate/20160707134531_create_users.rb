class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name, :limit => 20
      t.string :email, :limit => 20
      t.string :hash_password, :limit =>50
      t.string :city, :limit => 20
      t.string :company, :limit => 20

    end
  end
end
