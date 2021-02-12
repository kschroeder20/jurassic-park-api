class Dinosaur < ApplicationRecord
  belongs_to :cage, dependent: :destroy
  validates :name, presence: true
  validates :species, presence: true
  before_save :verify_cage_capacity
  after_save :update_cage_capacity

  private

  def verify_cage_capacity
    if self.cage.max_capacity - self.cage.current_capacity < 1
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def update_cage_capacity
    Cage.all.includes(:dinosaurs).each do |cage|
      cage.current_capacity = cage.dinosaurs.count
      cage.save!
    end
  end
end
