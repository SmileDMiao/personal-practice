# frozen_string_literal: true

class Types::Enum::Currency < Types::BaseEnum
  graphql_name "Currency"
  description "货币单位"

  %w[rmb usd eur].freeze
  value "rmb", "人民币"
  value "usd", "美元"
  value "eur", "欧元"
end
