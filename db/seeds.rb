# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cage.destroy_all
Dinosaur.destroy_all

(1..7).each do |id|
    cage = Cage.create!( max_capacity: 3 )
end
Dinosaur.create!(name: Faker::Name.name, species: 'Tyrannosaurus', cage: Cage.first)
Dinosaur.create!(name: Faker::Name.name, species: 'Tyrannosaurus', cage: Cage.first)
Dinosaur.create!(name: Faker::Name.name, species: 'Velociraptor', cage: Cage.second)
Dinosaur.create!(name: Faker::Name.name, species: 'Velociraptor', cage: Cage.second)
Dinosaur.create!(name: Faker::Name.name, species: 'Spinosaurus', cage: Cage.third)
Dinosaur.create!(name: Faker::Name.name, species: 'Spinosaurus', cage: Cage.third)
Dinosaur.create!(name: Faker::Name.name, species: 'Brachiosaurus', is_carnivor: true, cage: Cage.fourth)
Dinosaur.create!(name: Faker::Name.name, species: 'Brachiosaurus', is_carnivor: true, cage: Cage.fourth)
Dinosaur.create!(name: Faker::Name.name, species: 'Stegosaurus', is_carnivor: true, cage: Cage.fifth)
Dinosaur.create!(name: Faker::Name.name, species: 'Stegosaurus', is_carnivor: true, cage: Cage.fifth)
Dinosaur.create!(name: Faker::Name.name, species: 'Ankylosaurus', is_carnivor: true, cage: Cage.find(6))
Dinosaur.create!(name: Faker::Name.name, species: 'Ankylosaurus', is_carnivor: true, cage: Cage.find(6))
Dinosaur.create!(name: Faker::Name.name, species: 'Triceratops', is_carnivor: true, cage: Cage.find(7))
Dinosaur.create!(name: Faker::Name.name, species: 'Triceratops', is_carnivor: true, cage: Cage.find(7))
