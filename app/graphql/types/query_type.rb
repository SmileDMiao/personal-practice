# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false, description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :articles, [Types::ArticleType], null: false, resolver: Resolvers::Articles
    field :user, Types::UserType, "user", resolver: Resolvers::User
  end
end


# testFiled
# {
#   testFiled
# }

# Article List
# {
#   articles {
#     title,
#     body,
#     createdAt
#     user {
#       email
#     }
#   }
# }

# find user by id
# {
#   user(id: "7ff60960258d01387bcb784f437ccd66"){
#     fullName
#   }
# }
