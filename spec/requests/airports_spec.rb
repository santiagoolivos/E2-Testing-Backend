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
  end

  path '/airports' do
    get 'Obtener los aeropuertos' do
      tags 'Endpoints de Aeropuertos'
      produces 'application/json'
      security [bearerAuth: []]
      response '200', 'Retorna el listado de aeropuertos con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        run_test!
      end
    end

    post 'Registrar un aeropuerto' do
      tags 'Endpoints de Aeropuertos'
      produces 'application/json'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :airport_params, in: :body, schema: {
        type: :object,
        properties: {
          city: { type: :string, example: 'Santiago' },
          name: { type: :string, example: 'Arturo Merino Benitez International Airport' }
        },
        required: %w[city name]
      }

      response '201', 'Registra un nuevo vuelo con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:airport_params) { { city: 'Lima', name: 'Jorge Chávez International Airport' } }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:airport_params) { { city: 'Lima', name: 'Jorge Chávez International Airport' } }
        run_test!
      end
    end
  end

  path '/airports/{id}' do
    get 'Obtener un aeropuerto' do
      tags 'Endpoints de Aeropuertos'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, required: true

      response '200', 'Retorna el aeropuerto con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { @scl.id }
        run_test!
      end

      response '404', 'Aeropuerto no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:id) { @scl.id }
        run_test!
      end
    end

    patch 'Modificar un aeropuerto' do
      tags 'Endpoints de Aeropuertos'
      produces 'application/json'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, required: true
      parameter name: :airport_params, in: :body, schema: {
        type: :object,
        properties: {
          city: { type: :string, example: 'SCL-LIM' },
          name: { type: :string, example: '2020-01-01' }
        }
      }

      response '202', 'Modifica al aeropuerto con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:airport_params) { { city: 'Lim' } }
        let(:id) { @scl.id }
        run_test!
      end

      response '404', 'Vuelo no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:airport_params) { { city: 'Lim' } }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:airport_params) { { city: 'Lim' } }
        let(:id) { @scl.id }
        run_test!
      end
    end
  end
end
