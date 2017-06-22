MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :addComment, field: CommentMutations::Create.field

end