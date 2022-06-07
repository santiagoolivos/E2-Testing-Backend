require 'swagger_helper'

RSpec.describe 'flights', type: :request do
    before do
        @user = User.create(name: 'John',
          lastname: 'Doe',
          username: 'ohn@uc.cl',
          password_digest: '123456',
          role: 2)
        @scl = Airport.create(city: 'Santiago', name: 'Arturo Merino Benitez International Airport')
        @lim = Airport.create(city: 'Lima', name: 'Jorge Chávez International Airport')
        @flight = Flight.create(code: 'LIM-SCL',
                            date: '2020-01-01',
                            arrival_id: @scl.id,
                            departure_id: @lim.id
                        )
    end
    path '/flights/{flight_id}/seats' do
        get 'Obtener los asientos del asiento' do
            tags 'Endpoints de Asientos'
            produces 'application/json'
            parameter name: :flight_id, in: :path, required: true
            response '200', 'Retorna el listado de asientos con éxito' do
                let(:flight_id) { @flight.id } 
                run_test!
            end

            response '404', 'Vuelo no encontrado' do
              let(:flight_id) { 0 } 
              run_test!
            end
        end

        post 'Registrar un asiento' do
          tags 'Endpoints de Asientos'
            produces 'application/json'
            parameter name: :flight_id, in: :path, required: true
            consumes 'application/json'
            parameter name: :seat_params, in: :body, schema: {
              type: :object,
              properties: {
                user_id: { type: :string, example: 'SCL-LIM' },
                flight_id: { type: :string, example: '2020-01-01' },
                used: { type: :string, example: 1 },
                passenger_name: { type: :string, example: 2 },
                seat_code: {type: :strings, example: 2}
              },
              required: %w[user_id flight_id used passenger_name seat_code]
            }
      
            response '201', 'Registra un nuevo asiento con éxito' do
              let(:flight_id) { @flight.id } 
              let(:seat_params) { { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: "PILOT1"} }
              run_test!
            end

            response '404', 'Vuelo no encontrado' do
              let(:seat_params) { { user_id: @user.id, flight_id: @flight.id, used: true, passenger_name: @user.name, seat_code: "PILOT1"} }
              let(:flight_id) { 0 } 
              run_test!
            end
        end

    end
    path '/flights/{flight_id}/seats/{id}' do
      get 'Obtener un asiento del vuelo' do
        tags 'Endpoints de Asientos'
          produces 'application/json'
          parameter name: :flight_id, in: :path, required: true
          parameter name: :id, in: :path, required: true
          response '200', 'Retorna la información del asiento con éxito' do
            let(:flight_id) { @flight.id }
            let(:id) { @flight.seats.first }
              run_test!
          end

          response '404', 'Vuelo no encontrado' do
            let(:id) { @flight.seats.first }
            let(:flight_id) { 0 } 
            run_test!
          end

          response '404', 'Asiento no encontrado' do
            let(:flight_id) { @flight.id } 
            let(:id) { 0 }
            run_test!
          end
      end
    end
end
    