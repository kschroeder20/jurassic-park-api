require 'rails_helper'

RSpec.describe 'Dinosaurs API', type: :request do
  # # initialize test data
  # let!(:dinosaurs) { create_list(:dinosaur, 10) }
  # let(:dinosaur_id) { dinosaurs.first.id }
  # let!(:cages) { create_list(:cage, 10) }
  # let(:cage_id) { cages.first.id }

  # Initialize the test data
  let!(:cage) { create(:cage) }
  let!(:dinosaurs) { create_list(:dinosaur, 2, cage_id: cage.id) }
  let(:dinosaur_id) { dinosaurs.first.id }
  let(:inactive_cage) { create(:cage, active: false) }

  # Test suite for GET /dinosaurs
  describe 'GET /dinosaurs' do
    # make HTTP get request before each example
    before { get '/dinosaurs' }

    it 'returns dinosaurs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
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

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
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
    let(:valid_attributes) { { name: 'Paco', species: 'Dog' } }
    let(:invalid_attributes) { { name: 'Paco', species: 'Dog', cage_id: inactive_cage.id } }

    context 'when the record exists' do
      before { put "/dinosaurs/#{dinosaur_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the moving to a cage that is inactive' do
      before do
        inactive_cage = Cage.new(max_capacity: 100, active: false)
        inactive_cage.save
        put "/dinosaurs/#{dinosaur_id}", params: {:cage_id => inactive_cage.id}
      end

      it 'get an appropirate error message' do
        expect(response.body).to include("Invalid cage move. Cages must be active to move dinosaurs in and empty make inactive")
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when moving moving a carnivor into a cage with a herbavor' do
      before do
        new_cage = Cage.new(max_capacity: 100, active: true)
        second_new_cage = Cage.new(max_capacity: 100, active: true)
        new_cage.save
        second_new_cage.save

        herbavor = Dinosaur.new(name: 'Paco', species: 'Dog', cage_id: new_cage.id)
        carnivor = Dinosaur.new(name: 'Paco_2', species: 'Cat', is_carnivor: true, cage_id: second_new_cage.id)
        herbavor.save
        carnivor.save

        put "/dinosaurs/#{carnivor.id}", params: {:cage_id => new_cage.id}
      end

      it 'get an appropirate error message' do
        expect(response.body).to include("Carnivors and Herbivors can't be in the same cage")
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when moving moving a carnivor into a cage with a carnivor of a different species' do
      before do
        new_cage = Cage.new(max_capacity: 100, active: true)
        second_new_cage = Cage.new(max_capacity: 100, active: true)
        new_cage.save
        second_new_cage.save

        herbavor = Dinosaur.new(name: 'Paco', species: 'Dog', is_carnivor: true, cage_id: new_cage.id)
        carnivor = Dinosaur.new(name: 'Paco_2', species: 'Cat', is_carnivor: true, cage_id: second_new_cage.id)
        herbavor.save
        carnivor.save

        put "/dinosaurs/#{carnivor.id}", params: {:cage_id => new_cage.id}
      end

      it 'get an appropirate error message' do
        expect(response.body).to include("Can't move a Carnivor to a cage with Carnivor of a different species")
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
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

  # Test suite for GET /dinosaurs/species/:species
  describe 'GET /dinosaurs/species/:species' do
    before do
      herbavor = Dinosaur.new(name: 'Paco', species: 'Dog', is_carnivor: true)
      herbavor.save

      get "/dinosaurs/species/dog/"
    end

    it 'returns dinosaurs' do
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
 