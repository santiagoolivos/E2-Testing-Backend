# frozen_string_literal: true

# flight_controller.rb
class FlightsController < ApplicationController
  before_action :set_flight, only: %i[show update destroy]

  # GET /flights
  def index
    @flights = []
    Flight.all.each do |flight|
      @flights << flight.as_json(include: %i[arrival departure seats])
    end
    render json: @flights, status: :ok
  end

  # GET /flights/1
  def show
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    render json: @flight.as_json(include: %i[arrival departure seats]), status: :ok if @flight.present?
  end

  # POST /flights
  def create
    @flight = Flight.new(flight_params)

    if @flight.save
      create_seats(@flight)
      render json: @flight.as_json(include: %i[arrival departure seats]), status: :created, location: @flight
    else
      render json: @flight.errors, status: :unprocessable_entity
    end
  end

  def create_seats(flight)
    10.times do |row|
      Seat.create(flight_id: flight.id, used: false, seat_code: "A#{row + 1}")
      Seat.create(flight_id: flight.id, used: false, seat_code: "B#{row + 1}")
      Seat.create(flight_id: flight.id, used: false, seat_code: "C#{row + 1}")
      Seat.create(flight_id: flight.id, used: false, seat_code: "D#{row + 1}")
    end
  end

  # PATCH/PUT /flights/1
  def update
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    return unless @flight.present?

    if @flight.update(flight_params)
      render json: @flight, status: :accepted
    else
      render json: @flight.errors, status: :unprocessable_entity
    end
  end

  # DELETE /flights/1
  def destroy
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    return unless @flight.present?

    @flight.destroy
    render  json: { message: 'Vuelo eliminado' }, status: :accepted
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_flight
    @flight = Flight.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @flight = nil
  end

  # Only allow a list of trusted parameters through.
  def flight_params
    params.require(:flight).permit(:code, :date, :arrival_id, :departure_id)
  end
end
