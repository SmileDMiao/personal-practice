# frozen_string_literal: true

class PersonalPracticeSchema < GraphQL::Schema
  # use GraphQL::Execution::Interpreter
  # use GraphQL::Analysis::AST

  default_max_page_size 10
  use GraphQL::Pagination::Connections
  use GraphQL::Batch
  use BatchLoader::GraphQL
  enable_preloading


  mutation(Types::MutationType)
  query(Types::QueryType)
end
