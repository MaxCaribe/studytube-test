require 'faker'

FactoryBot.define do
  factory :bearer do
    name { Faker::Name.first_name }
  end
end
