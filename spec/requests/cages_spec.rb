# spec/requests/cages_spec.rb
require 'rails_helper'

RSpec.describe 'Dinosaur API', type: :request do
  # initialize test data
  let!(:cages) { create_list(:cage, 10) }
  let(:cage_id) { cages.first.id }

  # Test suite for GET /cages
  describe 'GET /cages' do
    # make HTTP get request before each example
    before { get '/cages' }

    it 'returns cages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /cages/:id
  describe 'GET /cages/:id' do
    before { get "/cages/#{cage_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(cage_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:cage_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(422)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cage/)
      end
    end
  end

  # Test suite for POST /cages
  describe 'POST /cages' do
    # valid payload
    let(:valid_attributes) { { max_capacity: 10, active: true } }
    let(:invalid_attributes) { { max_capacity: 10, active: true, current_occupancy: 10 } }

    context 'when the request is valid' do
      before { post '/cages', params: valid_attributes }

      it 'creates a cage' do
        expect(json['max_capacity']).to eq(10)
        expect(json['active']).to eq(true)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when trying to manipulate current_occupancy' do
      before { post '/cages', params: invalid_attributes }

      it 'get an appropriate error message' do
        expect(response.body).to include("Current occupancy can only be changed by adding/removing dinosaurs")
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /cages/:id
  describe 'PUT /cages/:id' do
    let(:valid_attributes) { { max_capacity: 10, active: true } }

    context 'when the record exists' do
      before { put "/cages/#{cage_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when turn off a cage with dinosaurs in it' do
      before do
        new_cage = Cage.new(max_capacity: 100, active: true)
        new_cage.save

        new_dinosaur = Dinosaur.new(name: 'Paco', species: 'Dog', cage_id: new_cage.id)
        new_dinosaur.save

        put "/cages/#{new_cage.id}", params: {:active => false}
      end

      it 'get an appropriate error message' do
        expect(response.body).to include("Invalid cage move. Cages must be active to move dinosaurs in and empty make inactive.")
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for DELETE /cages/:id
  describe 'DELETE /cages/:id' do
    before { delete "/cages/#{cage_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test suite for GET /cages/:id/dinosaurs
  describe 'GET /cages/:id/dinosaurs' do
    before do
      new_cage = Cage.new(max_capacity: 100, active: true)
      new_cage.save

      new_dinosaur = Dinosaur.new(name: 'Paco', species: 'Dog', cage_id: new_cage.id)
      new_dinosaur.save

      get "/cages/#{new_cage.id}/dinosaurs"
    end

    it 'returns cages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /cages/status/active
  describe 'GET /cages/status/active' do
    before do
      new_cage = Cage.new(max_capacity: 100, active: true)
      new_cage.save
      second_new_cage = Cage.new(max_capacity: 100, active: false)
      second_new_cage.save

      get "/cages/status/active"
    end

    it 'returns cages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /cages/status/active
  describe 'GET /cages/status/inactive' do
    before do
      new_cage = Cage.new(max_capacity: 100, active: true)
      new_cage.save
      second_new_cage = Cage.new(max_capacity: 100, active: false)
      second_new_cage.save

      get "/cages/status/inactive"
    end

    it 'returns cages' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end