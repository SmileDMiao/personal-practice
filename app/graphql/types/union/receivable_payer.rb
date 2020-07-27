# frozen_string_literal: true

class Types::Union::ReceivablePayer < Types::BaseUnion
  description "应收付款方"
  possible_types Types::CustomerType, Types::RelevanceType, Types::FactoryType, Types::WarehouseType

  def self.resolve_type(object, _context)
    "Types::#{object.class.name}Type".constantize
  end
end
