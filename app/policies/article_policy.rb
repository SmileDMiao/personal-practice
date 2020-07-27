# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  def update?
    record.user == user
  end
end
