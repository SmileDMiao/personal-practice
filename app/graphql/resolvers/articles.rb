# frozen_string_literal: true

module Resolvers
  class Articles < BaseResolver

    def resolve
      Article.all
    end
  end
end
