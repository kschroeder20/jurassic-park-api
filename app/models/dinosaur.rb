class Dinosaur < ApplicationRecord
  belongs_to :cage, dependent: :destroy
  validates :name, presence: true
  validates :species, presence: true
  before_save :verify_cage_capacity 
  before_save :check_for_diet_type
  before_save :check_for_species
  after_save :update_cage_capacity

  private

  def verify_cage_capacity
    if self.cage.max_capacity - self.cage.current_occupancy < 1
      raise StandardError.new "The cage is full"
    end
  end

  def verify_power_status
    if !self.cage.active
      raise StandardError.new "The cage that you are trying to move a dinosaur to is not active"
    end
  end

  def check_for_diet_type
    dinosaurs_in_cage = Cage.find(self.cage_id).dinosaurs
    unless Cage.find(cage_id).dinosaurs.count == 0 || dinosaurs_in_cage.where(is_carnivor: self.is_carnivor).count == Cage.find(cage_id).dinosaurs.count
      raise StandardError.new "Carnivors and Herbivors can't be in the same cage"
    end
  end

  def check_for_species
    if self.is_carnivor
      dinosaurs_in_cage = Cage.find(self.cage_id).dinosaurs
      unless Cage.find(cage_id).dinosaurs.count == 0 || dinosaurs_in_cage.where(species: self.species).count == Cage.find(cage_id).dinosaurs.count
        raise StandardError.new "Can't move a Carnivor to a cage with Carnivor of a different species"
      end
    end
  end

  def update_cage_capacity
    Cage.all.includes(:dinosaurs).each do |cage|
      cage.current_occupancy = cage.dinosaurs.count
      cage.save!
    end
  end
end
