# frozen_string_literal: true

class ArticleListener
  def article_create(article)
    puts article.title
  end
end
