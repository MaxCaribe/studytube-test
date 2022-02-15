require 'faker'

FactoryBot.define do
  factory :stock do
    name { Faker::Name.first_name }

    trait :with_bearer do
      bearer
    end
  end
end
