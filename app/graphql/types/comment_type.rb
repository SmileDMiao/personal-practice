CommentType = GraphQL::ObjectType.define do
  name 'Comment'
  field :body, types.String
end