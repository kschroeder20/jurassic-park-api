# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..10).each do |id|
    cage = Cage.create!( max_capacity: Faker::Number.number(digits: 2) )
end

(1..10).each do |id|
  offset = rand(Cage.count)
  rand_record = Cage.offset(offset).first
    Dinosaur.create!(
        name: Faker::Name.name,
        species: Faker::Name.name,
        cage: Cage.find(rand_record.id)

    )
end
