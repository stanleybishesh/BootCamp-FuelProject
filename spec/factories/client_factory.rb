FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "Bishesh (#{n})" }
    sequence(:email) { |n| "bishesh.shrestha@fleetpanda.com (#{n})" }
    sequence(:address) { |n| "Imadol (#{n})" }
    sequence(:phone) { |n| "9800000000 (#{n})" }
  end
end
