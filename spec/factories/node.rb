# frozen_string_literal: true

FactoryBot.define do
  factory :node do
    name { "database cleaner" }
    summary { "delete buy self name" }
    association :section
  end
end
