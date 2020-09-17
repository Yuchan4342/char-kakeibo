# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "test_category#{n}" }
  end
end
