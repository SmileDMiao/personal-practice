Types::QueryType = GraphQL::ObjectType.define do
  name '搜索'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :acticle do
    type ArticleType
    argument :title, !types.String
    description 'Find a article by title'
    resolve ->(obj, args, ctx) {
      Article.find_by_title(args["title"])
    }
  end

  field :acticle do
    type ArticleType
    argument :category, !types.String
    description 'Find a article by title'
    resolve ->(obj, args, ctx) {
      Article.all
    }
  end

end