# frozen_string_literal: true

class FetchGithubRepoJob < ApplicationJob
  queue_as :default

  # github repo
  def perform(user_id)
    User.fetch_github_repositories(user_id)
  end
end
