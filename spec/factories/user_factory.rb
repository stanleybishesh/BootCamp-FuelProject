FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User (#{n})" }
    sequence(:email) { |n| "user#{n}@fleetpanda.com" }
    password { "password123" }
    tenant
  end
end
