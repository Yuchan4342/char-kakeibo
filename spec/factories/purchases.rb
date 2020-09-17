# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    sequence(:name) { |n| "test_purchase#{n}" }
  end
end
