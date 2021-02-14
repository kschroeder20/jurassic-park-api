require 'faker'

FactoryBot.define do
  factory :cage do
    max_capacity 100
    active true
  end
end