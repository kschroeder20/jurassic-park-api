require 'faker'

FactoryBot.define do
  factory :cage do
    max_capacity { Faker::Number.number(10) }
    current_occupancy { Faker::Number.number(10) }
  end
end