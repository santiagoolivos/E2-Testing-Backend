# frozen_string_literal: true

# seats_controller.rb
class SeatsController < ApplicationController
  before_action :set_flight, only: %i[index show create update destroy]
  before_action :set_seat, only: %i[show update destroy]

  # GET /flights/:flight_id/seats
  def index
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    render json: @flight.seats, status: :ok if @flight.present?
  end

  # GET /flights/:flight_id/seats/1
  def show
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    return unless @flight.present?

    render json: { error: 'No se ha encontrado el asiento / no pertenece al vuelo' }, status: :not_found if @seat.blank?
    return unless @seat.present?

    render json: @seat
  end

  # POST /flights/:flight_id/seats
  def create
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    return unless @flight.present?

    @seat = Seat.new(seat_params)

    if @seat.save
      @flight.seats << @seat
      render json: @seat, status: :created
    else
      render json: @seat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /flights/:flight_id/seats/1
  def update
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    return unless @flight.present?

    render json: { error: 'No se ha encontrado el asiento / no pertenece al vuelo' }, status: :not_found if @seat.blank?
    return unless @seat.present?

    if @seat.update(seat_params)
      render json: @seat, status: :accepted
    else
      render json: @seat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /flights/:flight_id/seats/1
  def destroy
    render json: { error: 'No se ha encontrado el vuelo' }, status: :not_found if @flight.blank?
    return unless @flight.present?

    render json: { error: 'No se ha encontrado el asiento' }, status: :not_found if @seat.blank?
    return unless @seat.present?

    @seat.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_seat
    @seat = Seat.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @seat = nil
  end

  # Only allow a list of trusted parameters through.
  def seat_params
    params.require(:seat).permit(:user_id, :flight_id, :used, :passenger_name, :seat_code)
  end

  def set_flight
    @flight = Flight.find(params[:flight_id])
  rescue ActiveRecord::RecordNotFound
    @flight = nil
  end
end
