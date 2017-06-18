ArticleType = GraphQL::ObjectType.define do
  name 'Article'
  field :id, types.String
  field :title, types.String
  field :body, types.String
  field :comments, types[CommentType]
end