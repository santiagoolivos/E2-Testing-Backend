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
    render json: @seat
  end

  # POST /seats
  def create
    @seat = Seat.new(seat_params)

    if @seat.save
      render json: @seat, status: :created, location: @seat
    else
      render json: @seat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /seats/1
  def update
    if @seat.update(seat_params)
      render json: @seat
    else
      render json: @seat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /seats/1
  def destroy
    @seat.destroy
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_seat
    @seat = Seat.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def seat_params
    params.require(:seat).permit(:user_id, :flight_id, :used, :passenger_name, :seat_code)
  end

  def set_flight
    begin
      @flight = Flight.find(params[:flight_id])
    rescue ActiveRecord::RecordNotFound => e
      @flight = nil
    end
  end
end
