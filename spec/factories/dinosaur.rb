require 'faker'

FactoryBot.define do
  factory :dinosaur do
    name { Faker::Superhero.name }
    species "Dog"
    cage_id nil
  end
end