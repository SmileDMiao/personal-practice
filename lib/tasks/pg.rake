# frozen_string_literal: true

namespace :pg do
  desc "Create db user"
  task user: :environment do
    login_user = ENV["USER"]
    user = login_user
    password = "123456"
    host = "localhost"

    sql = "create user #{user} with password '#{password}' createdb; ALTER USER #{user} WITH SUPERUSER;"
    cmd = "psql -U #{login_user} -h #{host} -c \"#{sql}\""

    sh cmd
  end
end
