# frozen_string_literal: true

class SearchIndexerWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :notifications, retry: true, backtrace: true

  def perform(operation, type, id)
    obj = nil
    type.downcase!

    case type
    when "article"
      obj = Article.find_by_id(id)
    when "user"
      obj = User.find_by_id(id)
    end

    return false unless obj

    if operation == "update"
      obj.__elasticsearch__.update_document
    elsif operation == "delete"
      obj.__elasticsearch__.delete_document
    elsif operation == "index"
      obj.__elasticsearch__.index_document
    end
  end
end
