FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    tenant
  end
end
