class CagesController < ApplicationController
  before_action :set_cage, only: [:show, :update, :destroy]

  # GET /cages
  def index
    @cages = Cage.all
    json_response(@cages)
  end

  # POST /cages
  def create
    puts cage_params
    @cage = Cage.create!(cage_params)
    json_response(@cage, :created)
  end

  # GET /cages/:id
  def show
    json_response(@cage)
  end

  # PUT /cages/:id
  def update
    @cage.update(cage_params)
    head :no_content
  end

  # DELETE /cages/:id
  def destroy
    @cage.destroy
    head :no_content
  end

  private

  def cage_params
    # whitelist params
    params.permit(:max_capacity, :current_capacity, :power)
  end

  def set_cage
    @cage = Cage.find(params[:id])
  end
end
