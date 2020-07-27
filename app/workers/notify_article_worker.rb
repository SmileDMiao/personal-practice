# frozen_string_literal: true

class NotifyArticleWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :notifications, retry: false, backtrace: true

  def perform(article_id)
    Article.notify_article_created(article_id)
  end
end
