# frozen_string_literal: true

module Resolvers
  class Articles < BaseResolver
    type Types::ArticleType.connection_type, null: false

    def resolve
      Article.all
    end
  end
end
