class Dinosaur < ApplicationRecord
  belongs_to :cage, dependent: :destroy
  validates :name, presence: true
  validates :species, presence: true
end
