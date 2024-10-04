FactoryBot.define do
  factory :tenant do
    sequence(:name) { |n| "Tenant #{n}" }
  end
end
