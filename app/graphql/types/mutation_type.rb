module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :createComment, mutation: Mutations::Comments::Create
    field :deleteComment, mutation: Mutations::Comments::Delete
    field :updateComment, mutation: Mutations::Comments::Update
  end
end

# Create Comment
# mutation {
#   createComment(input: {body: "123", articleId: "756f6840259701387bcf784f437ccd66", userId: "7ff60960258d01387bcb784f437ccd66"}) {
#     comment {
#       id
#       body
#     }
#   }
# }

# Delete Comment
# mutation {
#   deleteComment(input: {id: "64860ed0259901387bcf784f437ccd66"}) {
#     comment {
#       id
#       body
#     }
#   }
# }

# Update Comment
# mutation {
#   updateComment(input: {id: "5bacb81052310138d4fb02cbd5e95801", body: "aaaaaa"}) {
#     comment {
#       id
#       body
#     }
#   }
# }



