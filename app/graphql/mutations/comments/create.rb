# frozen_string_literal: true

module Mutations
  class Comments::Create < BaseMutation
    graphql_name "CreateComment"
    description "创建评论"

    field :comment, Types::CommentType, null: true

    argument :body, String, required: true
    argument :article_id, String, required: false
    argument :user_id, String, required: true

    def resolve(**inputs)
      comment = Comment.create!(inputs)
      {comment: comment}
    end
  end
end
