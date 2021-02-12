require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
  # Association test
  # ensure an item record belongs to a single cage record
  it { should belong_to(:cage) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:species) }
end
