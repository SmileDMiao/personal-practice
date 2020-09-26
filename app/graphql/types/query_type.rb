# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :articles, "文章列表", resolver: Resolvers::Articles
    field :user, Types::UserType, "user", resolver: Resolvers::User
  end
end
