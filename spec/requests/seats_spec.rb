# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'flights', type: :request do
  before do
    @user = User.create(name: 'John',
                        lastname: 'Doe',
                        username: 'ohn@uc.cl',
                        password: '123456',
                        role: 2)
    @scl = Airport.create(city: 'Santiago', name: 'Arturo Merino Benitez International Airport')
    @lim = Airport.create(city: 'Lima', name: 'Jorge Chávez International Airport')
    @flight = Flight.create(code: 'LIM-SCL',
                            date: '2020-01-01',
                            arrival_id: @scl.id,
                            departure_id: @lim.id)
    @seat = Seat.create(user_id: @user.id,
                        flight_id: @flight.id,
                        used: true,
                        passenger_name: 'Raimundo',
                        seat_code: 'A1')
    @flight.seats << @seat
  end
  path '/flights/{flight_id}/seats' do
    get 'Obtener los asientos del asiento' do
      tags 'Endpoints de Asientos'
      produces 'application/json'
      parameter name: :flight_id, in: :path, required: true
      security [bearerAuth: []]
      response '200', 'Retorna el listado de asientos con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_id) { @flight.id }
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:flight_id) { @flight.id }
        run_test!
      end
    end

    post 'Registrar un asiento' do
      tags 'Endpoints de Asientos'
      produces 'application/json'
      parameter name: :flight_id, in: :path, required: true
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :seat_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer, example: 2 },
          flight_id: { type: :integer, example: 2 },
          used: { type: :string, example: true },
          passenger_name: { type: :string, example: 'Raimundo' },
          seat_code: { type: :strings, example: 'A1' }
        },
        required: %w[user_id flight_id used passenger_name seat_code]
      }

      response '201', 'Registra un nuevo asiento con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_id) { @flight.id }
        let(:seat_params) do
          { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: 'PILOT1' }
        end
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:seat_params) do
          { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: 'PILOT1' }
        end
        let(:flight_id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:flight_id) { @flight.id }
        let(:seat_params) do
          { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: 'PILOT1' }
        end
        run_test!
      end
    end
  end

  path '/flights/{flight_id}/seats/{id}/' do
    get 'Obtener un asiento del vuelo' do
      tags 'Endpoints de Asientos'
      produces 'application/json'
      parameter name: :id, in: :path, required: true
      parameter name: :flight_id, in: :path, required: true
      security [bearerAuth: []]
      response '200', 'Retorna la información del asiento con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_id) { @flight.id }
        let(:id) { @seat.id }
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_id) { 0 }
        let(:id) { @seat.id }
        run_test!
      end

      response '404', 'Asiento no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_id) { @flight.id }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:flight_id) { @flight.id }
        let(:id) { @seat.id }
        run_test!
      end
    end

    patch 'Editar un asiento del vuelo' do
      tags 'Endpoints de Asientos'
      produces 'application/json'
      parameter name: :flight_id, in: :path, required: true
      parameter name: :id, in: :path, required: true
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :seat_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer, example: 2 },
          flight_id: { type: :integer, example: 2 },
          used: { type: :boolean, example: true },
          passenger_name: { type: :string, example: 'Raimundo' },
          seat_code: { type: :strings, example: 'A1' }
        }
      }

      response '202', 'Registra un nuevo asiento con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_id) { @flight.id }
        let(:id) { @seat.id }
        let(:seat_params) do
          { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: 'A1' }
        end
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:seat_params) do
          { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: 'A!' }
        end
        let(:flight_id) { 0 }
        let(:id) { @seat.id }
        run_test!
      end

      response '404', 'Asiento no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:seat_params) do
          { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: 'A!' }
        end
        let(:flight_id) { @flight.id }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:flight_id) { @flight.id }
        let(:id) { @seat.id }
        let(:seat_params) do
          { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: 'PILOT1' }
        end
        run_test!
      end
    end
  end
end
