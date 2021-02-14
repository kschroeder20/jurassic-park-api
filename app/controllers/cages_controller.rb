class CagesController < ApplicationController
  before_action :set_cage, only: [:show, :update, :destroy, :show_dinosaurs]

  # GET /cages
  def index
    @cages = Cage.all
    json_response(@cages)
  end

  # POST /cages
  def create
    throw_error("Current occupancy can only be changed by adding/removing dinosaurs") if params.has_key?(:current_occupancy)
    @cage = Cage.create!(cage_params)
    json_response(@cage, :created)
  end

  # GET /cages/:id
  def show
    json_response(@cage)
  end

  # PUT /cages/:id
  def update
    throw_error("Current occupancy can only be changed by adding/removing dinosaurs") if params.has_key?(:current_occupancy)
    @cage.update!(cage_params)
    head :no_content
  end

  # DELETE /cages/:id
  def destroy
    @cage.destroy
    head :no_content
  end

  # GET /cages/:id/dinosaurs
  def show_dinosaurs
    json_response(@cage.dinosaurs)
  end

  # GET /cages/active
  def show_active
    json_response(Cage.all.where(active: true))
  end

  # GET /cages/inactive
  def show_inactive
    json_response(Cage.all.where(active: false))
  end

  private

  def cage_params
    # whitelist params
    params.permit(:max_capacity, :active)
  end

  def set_cage
    @cage = Cage.find(params[:id])
  end

  def throw_error(message)
    raise StandardError.new "#{message}"
  end
end
