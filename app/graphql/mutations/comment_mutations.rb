module CommentMutations

  Create = GraphQL::Relay::Mutation.define do
    name 'AddComment'

    input_field :articleId, !types.ID
    input_field :userId, !types.ID
    input_field :comment, !types.String

    # The result has access to these fields,
    # resolve must return a hash with these keys.
    # On the client-side this would be configured
    # as RANGE_ADD mutation, so our returned fields
    # must conform to that API.
    return_field :article, ArticleType
    return_field :errors, types.String

    resolve ->(object, inputs, ctx) {

      article = Article.find_by_id(inputs[:articleId])
      return {errors: "Article not found"} if article.nil?

      comments = article.comments
      new_comment = comments.build(user_id: inputs[:userId], body: inputs[:comment])

      if new_comment.save
        {article: article}
      else
        {errors: new_comment.errors.to_a}
      end

    }

  end

end