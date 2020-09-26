# frozen_string_literal: true

module Types
  class ArticleType < Types::BaseObject
    graphql_name "Article"

    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :like_account, Integer, null: false
    field :comment_account, Integer, null: false
    field :user, Types::UserType, "作者", null: false, preload: :user
    field :comments, Types::CommentType.connection_type, null: true, preload: :comments
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
