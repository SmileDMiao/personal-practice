# frozen_string_literal: true

class PersonalPracticeSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  # Enable preloading
  use GraphQL::Batch
  enable_preloading

  # Batch Loader
  use BatchLoader::GraphQL

  class << self
    def id_from_object(object, type_definition, ctx)
      GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
    end

    def object_from_id(id, ctx)
      return unless id

      class_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
      raise ArgumentError if class_name.blank? || item_id.blank?

      Object.const_get(class_name).find(item_id)
    rescue ArgumentError
      message = "非法参数：#{id}"
      raise GraphQL::ExecutionError, message
    rescue ActsAsTenant::Errors::NoTenantSet => e
      unauthorized_object(e)
    end

    def unauthorized_object(error)
      message = "未登录或者登录过期"
      raise GraphQL::ExecutionError.new(message, options: { code: 401, detail: "Unauthorized" })
    end

    def unauthorized_field(error)
      message = "未登录或者登录过期"
      raise GraphQL::ExecutionError.new(message, options: { code: 401, detail: "Unauthorized" })
    end
  end
end
