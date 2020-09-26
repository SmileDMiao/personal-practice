# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    graphql_name "Comment"

    field :id, ID, null: false
    field :body, String, null: true
    field :user, Types::UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
