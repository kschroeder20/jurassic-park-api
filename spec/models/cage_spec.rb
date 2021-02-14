require 'rails_helper'

RSpec.describe Cage, type: :model do
  # Association test
  # ensure Cage model has a 1:m relationship with the Dinosaur model
  it { should have_many(:dinosaurs).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:max_capacity) }
  it { should validate_presence_of(:current_occupancy) }
end
