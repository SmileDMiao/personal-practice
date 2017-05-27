namespace :elasticsearch do

  desc 'import data elasticsearch needed'
  task :import_date => :environment do

    mappings do
      indexes :title, term_vector: :yes
      indexes :body, term_vector: :yes
    end

    Article.__elasticsearch__.create_index!(index: 'personal')
    transform = lambda do |a|
      {index: {title: a.title, body: a.body}}
    end
    Article.import(index: 'personal', type: 'articles')

  end

end
