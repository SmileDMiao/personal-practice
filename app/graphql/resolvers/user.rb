# frozen_string_literal: true

module Resolvers
  class User < Resolvers::BaseResolver
    type Types::UserType, null: true

    argument :id, ID, "user id", required: true

    def resolve(id:)
      ::User.find(id)
    end
  end
end
