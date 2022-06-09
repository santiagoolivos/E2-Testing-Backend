# frozen_string_literal: true

# airport controller
class AirportsController < ApplicationController
  before_action :set_airport, only: %i[show update destroy]

  # GET /airports
  def index
    render json: Airport.all, status: :ok
  end

  # GET /airports/1
  def show
    render json: { error: 'No se ha encontrado el aeropuerto' }, status: :not_found if @airport.blank?
    return unless @airport.present?

    render json: @airport, status: :ok
  end

  # POST /airports
  def create
    @airport = Airport.new(airport_params)

    if @airport.save
      render json: @airport, status: :created, location: @airport
    else
      render json: @airport.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /airports/1
  def update
    render json: { error: 'No se ha encontrado el aeropuerto' }, status: :not_found if @airport.blank?
    return unless @airport.present?

    if @airport.update(airport_params)
      render json: @airport, status: :accepted
    else
      render json: @airport.errors, status: :unprocessable_entity
    end
  end

  # DELETE /airports/1
  def destroy
    render json: { error: 'No se ha encontrado el aeropuerto' }, status: :not_found if @airport.blank?
    return unless @airport.present?

    @airport.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_airport
    @airport = Airport.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @airport = nil
  end

  # Only allow a list of trusted parameters through.
  def airport_params
    params.require(:airport).permit(:name, :city)
  end
end
