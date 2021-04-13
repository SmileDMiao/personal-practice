# frozen_string_literal: true

module Mutations
  class Comments::Update < BaseMutation
    graphql_name "UpdateComment"
    description "更新评论"

    field :comment, Types::CommentType, null: true

    argument :id, ID, required: true
    argument :body, String, required: true

    def resolve(id:, body:)
      comment = Comment.find(id)
      comment.update!(body: body) if comment
      {comment: comment}
    end
  end
end
