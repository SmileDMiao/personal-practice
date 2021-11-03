class CreateBulkUpserts < ActiveRecord::Migration[6.1]
  def change
    create_table :bulk_upserts do |t|
      t.string :name, limit: 20
      t.string :email, limit: 20
      t.string :city, limit: 20
      t.timestamps null: false
      t.index ["name"], name: "index_bulk_name", unique: true, using: :btree
    end

    # Postgres can test in this project's database
    # Mysql
    # 'create schema blog default character set utf8 collate utf8_bin'
    # ActiveRecord::Base.establish_connection(
    #     adapter: 'mysql2',
    #     host: 'localhost',
    #     username: 'root',
    #     password: 'root',
    #     database: 'blog'
    # )

    # ActiveRecord::Base.connection.create_table :bulk_upserts do |t|
    #   t.string :name, :limit => 20
    #   t.string :email, :limit => 20
    #   t.string :city, :limit => 20
    #   t.timestamps null: false
    #   t.index ["name"], name: "index_bulk_name", unique: true, using: :btree
    # end

    # ActiveRecord::Base.establish_connection(
    #     adapter: 'postgresql',
    #     host: 'localhost',
    #     username: 'postgres',
    #     password: 'postgres',
    #     database: 'blog'
    # )

    # Mysql
    # %Q( INSERT INTO bulk_upserts (name, email, city, created_at, updated_at)
    # VALUES ( 'miao1', 'bbcccc@qq.com', 'a', '2016-01-01', '2016-01-01'),
    #        ('miao2', 'bbcccc@qq.com', 'a', '2016-01-01', '2016-01-01'),
    #        ('miao2', 'bbccccdd@qq.com', 'a', '2016-01-01', '2016-01-01')
    # ON DUPLICATE KEY UPDATE
    # email = VALUES(email); )

    # Postgresql
    # %Q( INSERT INTO bulk_upserts (name, email, city, created_at, updated_at)
    # VALUES ( 'miao1', 'bbcccc@qq.com', 'a', '2016-01-01', '2016-01-01'),
    #        ('miao2', 'bbcccc@qq.com', 'a', '2016-01-01', '2016-01-01'),
    #        ('miao2', 'bbccccdd@qq.com', 'a', '2016-01-01', '2016-01-01')
    # ON CONFLICT(name) DO  UPDATE
    # SET email = EXCLUDED.email;)

    # CONNECTION
    # connection = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root", :database => "blog")
    # Single record Mysql
    # upsert = Upsert.new connection, :bulk_upserts
    # upsert.row({:name => 'a'}, name: 'a', email: 'sssss.sql', created_at: '2016-01-01', updated_at: '2016-01-01')

    # Batch Operation
    # Upsert.batch(connection, :bulk_upserts) do |upsert|
    #   upsert.row({:name => 'a'}, name: 'a', email: 'sssss.sql', created_at: '2016-01-01', updated_at: '2016-01-01')
    #   upsert.row({:name => 'b'}, name: 'b', email: 'ss123123.sql', created_at: '2016-01-01', updated_at: '2016-01-01')
    # end

    # CONNECTION
    # connection = PG.connect(:user => "postgres", :password => "postgres", :dbname => 'blog')
    # Batch Operation Postgresql
    # Upsert.batch(connection, :bulk_upserts) do |upsert|
    #   upsert.row(name: 'a', email: 'ssddddd.sql', created_at: '2017-01-01', updated_at: '2016-01-01')
    #   upsert.row(name: 'b', email: 'ss.sql', created_at: '2016-01-01', updated_at: '2016-01-01')
    # end
  end
end
