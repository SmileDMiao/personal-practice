namespace :elasticsearch do

  desc 'import data elasticsearch needed'
  task :import_date => :environment do


    Article.__elasticsearch__.create_index!(index: 'personal')

    Article.import(index: 'personal', type: 'articles')

  end

end
