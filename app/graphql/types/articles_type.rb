ArticlesType = GraphQL::ObjectType.define do
  # `Post#comments` returns an ActiveRecord::Relation
  # The GraphQL field returns a Connection
  connection :comments, CommentType.connection_type
end