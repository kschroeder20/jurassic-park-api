require 'faker'

FactoryBot.define do
  factory :dinosaur do
    name { Faker::Superhero.name }
    species { Faker::Lorem.word }
    cage_id nil
  end
end