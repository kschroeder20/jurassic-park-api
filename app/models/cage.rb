class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :destroy
  validates :max_capacity, presence: true
  validates :current_capacity, presence: true

end
