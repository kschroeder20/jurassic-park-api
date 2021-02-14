class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :destroy
  validates :max_capacity, presence: true
  validates :current_occupancy, presence: true
  before_save :verify_cage_is_empty

  private

  def verify_cage_is_empty
    if !self.active && self.dinosaurs.count > 0 && Cage.find(self.id).dinosaurs.count != 0
      raise StandardError.new "Invalid cage move. Cages must be active to move dinosaurs in and empty make inactive."
    end
  end
end
