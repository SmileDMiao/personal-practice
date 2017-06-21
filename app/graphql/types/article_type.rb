ArticleType = GraphQL::ObjectType.define do
  name 'Article'
  # `!` marks a field as "non-null"
  field :id, types.ID
  field :title, types.String
  field :body, types.String
  field :like_account, types.Int
  field :comment_account, types.Int
  field :comments, types[CommentType]
  field :user, UserType
end