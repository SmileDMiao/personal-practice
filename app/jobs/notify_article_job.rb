# frozen_string_literal: true

class NotifyArticleJob < ApplicationJob
  queue_as :default

  def perform(article_id)
    Article.notify_article_created(article_id)
  end
end
