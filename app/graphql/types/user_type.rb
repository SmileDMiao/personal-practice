UserType = GraphQL::ObjectType.define do
  name 'User'
  field :id, types.String
  field :full_name, types.String
  field :email, types.String
  field :auth_token, types.String
  field :city, types.String
  field :company, types.String
  field :github, types.String
  field :twiteer, types.String
  field :article_count, types.Int
  field :comment_count, types.Int
  field :tagline, types.String
  field :created_at, types.String
end