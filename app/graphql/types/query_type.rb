Types::QueryType = GraphQL::ObjectType.define do
  name '搜索'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :acticle do
    type ArticleType
    argument :title, !types.String
    description 'Find a article by title'
    resolve ->(obj, args, ctx) {
      Article.find_by_title(args['title'])
    }
  end

  field :acticle do
    type types[ArticleType]
    argument :category, !types.String
    description 'Find all articles'
    resolve ->(obj, args, ctx) {
      Article.all
    }
  end

  field :user do
    type types[UserType]
    description 'Find all users'
    resolve ->(obj, args, ctx) {
      User.all
    }
  end

end