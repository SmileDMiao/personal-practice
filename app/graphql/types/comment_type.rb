CommentType = GraphQL::ObjectType.define do
  name 'Comment'
  field :body, types.String
  field :article, types[ArticleType]
end