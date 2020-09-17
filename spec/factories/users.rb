# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_user#{n}@example.com" }
    sequence(:name) { |n| "test_user#{n}" }
  end
end
