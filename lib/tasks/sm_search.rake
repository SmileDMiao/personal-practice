# encoding: utf-8
namespace :sm_search do

  desc '用于搜索的redis测试数据'
  task :test_search_data => :environment do

    Food.all.each do |f|
      food_json = {
          id: f.id,
          term: f.name,
          score: f.number
      }
      food_json = JSON.parse(food_json.to_json )
      Soulmate::Loader.new("Food").add(food_json)
    end

    User.all.each do |u|
      user_json = {
          id: u.id,
          term: u.full_name,
          score: "1"
      }
      user_json = JSON.parse(user_json.to_json )
      Soulmate::Loader.new("User").add(user_json)
    end

    Article.all.each do |a|
      article_json = {
          id: a.id,
          term: a.title,
          score: a.comment_count
      }
      article_json = JSON.parse(article_json.to_json )
      Soulmate::Loader.new("Article").add(article_json)
    end
  end
end
