class DinosaursController < ApplicationController
  before_action :set_dinosaur, only: [:show, :update, :destroy]

  # GET /dinosaurs
  def index
    @dinosaurs = Dinosaur.all
    json_response(@dinosaurs)
  end

  # POST /dinosaurs
  def create
    @dinosaur = Dinosaur.create!(dinosaur_params)
    json_response(@dinosaur, :created)
  end

  # GET /dinosaurs/:id
  def show
    json_response(@dinosaur)
  end

  # PUT /dinosaurs/:id
  def update
    @dinosaur.update!(dinosaur_params)
    head :no_content
  end

  # DELETE /dinosaurs/:id
  def destroy
    @dinosaur.destroy!
    head :no_content
  end

  # GET /dinosaurs/species/:species
  def by_species
    json_response(Dinosaur.where('lower(species) = ?', params['species'].downcase))
  end

  private

  def dinosaur_params
    # whitelist params
    params.permit(:name, :species, :is_carnivor, :cage_id)
  end

  def set_dinosaur
    @dinosaur = Dinosaur.find(params[:id])
  end
end
