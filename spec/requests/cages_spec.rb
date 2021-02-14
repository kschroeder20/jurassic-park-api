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
      # Note `json` is a custom helper to parse JSON responses
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
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cage/)
      end
    end
  end

  # Test suite for POST /cages
  describe 'POST /cages' do
    # valid payload
    let(:valid_attributes) { { max_capacity: 10, current_occupancy: 0 } }

    context 'when the request is valid' do
      before { post '/cages', params: valid_attributes }

      it 'creates a cage' do
        expect(json['max_capacity']).to eq(10)
        expect(json['current_occupancy']).to eq(0)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /cages/:id
  describe 'PUT /cages/:id' do
    let(:valid_attributes) { { max_capacity: 10, current_occupancy: 0 } }

    context 'when the record exists' do
      before { put "/cages/#{cage_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
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
end