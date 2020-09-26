# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :createComment, mutation: Mutations::Comments::Create
    field :deleteComment, mutation: Mutations::Comments::Delete
    field :updateComment, mutation: Mutations::Comments::Update
  end
end
