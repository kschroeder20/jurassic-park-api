class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :destroy
  validates :max_capacity, presence: true
  validates :current_capacity, presence: true
  before_save :verify_cage_is_empty
  
  private

  def verify_cage_is_empty
    if !self.power && self.dinosaurs.count > 0
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end


end
