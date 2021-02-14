require 'rails_helper'

RSpec.describe 'Dinosaurs API', type: :request do
  # # initialize test data
  # let!(:dinosaurs) { create_list(:dinosaur, 10) }
  # let(:dinosaur_id) { dinosaurs.first.id }
  # let!(:cages) { create_list(:cage, 10) }
  # let(:cage_id) { cages.first.id }

  # Initialize the test data
  let!(:cage) { create(:cage) }
  let!(:dinosaurs) { create_list(:dinosaur, 20, cage_id: cage.id) }
  let(:dinosaur_id) { dinosaurs.first.id }

  # Test suite for GET /dinosaurs
  describe 'GET /dinosaurs' do
    # make HTTP get request before each example
    before { get '/dinosaurs' }

    it 'returns dinosaurs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /dinosaurs/:id
  describe 'GET /dinosaurs/:id' do
    before { get "/dinosaurs/#{dinosaur_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(dinosaur_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:dinosaur_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Dinosaur/)
      end
    end
  end

  # Test suite for POST /dinosaurs
  describe 'POST /dinosaurs' do
    # valid payload
    let(:valid_attributes) { { name: 'Paco', species: 'Dog', cage_id: cage.id } }

    context 'when the request is valid' do
      before { post '/dinosaurs', params: valid_attributes }

      it 'creates a dinosaur' do
        expect(json['name']).to eq('Paco')
        expect(json['species']).to eq('Dog')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /dinosaurs/:id
  describe 'PUT /dinosaurs/:id' do
    let(:valid_attributes) { { max_capacity: 10, current_occupancy: 0 } }

    context 'when the record exists' do
      before { put "/dinosaurs/#{dinosaur_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /dinosaurs/:id
  describe 'DELETE /dinosaurs/:id' do
    before { delete "/dinosaurs/#{dinosaur_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
 