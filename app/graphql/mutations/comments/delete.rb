# frozen_string_literal: true

module Mutations
  class Comments::Delete < BaseMutation
    graphql_name "DeleteComment"
    description "删除评论"

    field :comment, Types::CommentType, null: true

    argument :id, String, required: true

    def resolve(id:)
      comment = Comment.find(id).destroy
      { comment: comment }
    end
  end
end
