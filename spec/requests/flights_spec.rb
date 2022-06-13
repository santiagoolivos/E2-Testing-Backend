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
  end

  path '/flights' do
    get 'Obtener los vuelos' do
      tags 'Endpoints de Vuelos'
      produces 'application/json'
      security [bearerAuth: []]
      response '200', 'Retorna el listado de vuelos con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        run_test!
      end
    end

    post 'Registrar un vuelo' do
      tags 'Endpoints de Vuelos'
      produces 'application/json'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :flight_params, in: :body, schema: {
        type: :object,
        properties: {
          code: { type: :string, example: 'SCL-LIM' },
          date: { type: :string, example: '2020-01-01' },
          arrival_id: { type: :string, example: 1 },
          departure_id: { type: :string, example: 2 }
        },
        required: %w[code date arrival_id departure_id]
      }

      response '201', 'Registra un nuevo vuelo con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_params) do
          { code: 'SCL-LIM', date: '2020-01-01', arrival_id: @lim.id, departure_id: @scl.id }
        end
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:flight_params) do
          { code: 'SCL-LIM', date: '2020-01-01', arrival_id: @lim.id, departure_id: @scl.id }
        end
        run_test!
      end
    end
  end

  path '/flights/{id}' do
    get 'Obtener un vuelo' do
      tags 'Endpoints de Vuelos'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, required: true

      response '200', 'Retorna el vuelo con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { @flight.id }
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:id) { @flight.id }
        run_test!
      end
    end

    patch 'Modificar un vuelo' do
      tags 'Endpoints de Vuelos'
      produces 'application/json'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, required: true
      parameter name: :flight_params, in: :body, schema: {
        type: :object,
        properties: {
          code: { type: :string, example: 'SCL-LIM' },
          date: { type: :string, example: '2020-01-01' },
          arrival_id: { type: :string, example: 1 },
          departure_id: { type: :string, example: 2 }
        }
      }

      response '202', 'Modifica al vuelo con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_params) { { code: 'Lim' } }
        let(:id) { @flight.id }
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:flight_params) { { code: 'Lim' } }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:flight_params) { { code: 'Lim' } }
        let(:id) { @flight.id }
        run_test!
      end
    end

    delete 'Eliminar un vuelo' do
      tags 'Endpoints de Vuelos'
      produces 'application/json'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, required: true

      response '202', 'Elimina el vuelo con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { @flight.id }
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:id) { @flight.id }
        run_test!
      end
    end
  end
end
