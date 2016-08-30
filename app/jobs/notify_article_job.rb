class NotifyArticleJob < ActiveJob::Base
  queue_as :default

  def perform(article_id)
    Article.notify_article_created(article_id)
  end
end
