# frozen_string_literal: true

class FetchGithubRepoWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :default, retry: false, backtrace: true

  def perform(user_id)
    User.fetch_github_repositories(user_id)
  end
end
