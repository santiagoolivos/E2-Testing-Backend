require 'swagger_helper'

RSpec.describe 'flights', type: :request do
    before do
        @scl = Airport.create(city: 'Santiago', name: 'Arturo Merino Benitez International Airport')
        
    end

    path '/airports' do
        get 'Obtener los aeropuertos' do
            tags 'Endpoints de Aeropuertos'
            produces 'application/json'
            response '200', 'Retorna el listado de aeropuertos con éxito' do
                run_test!
            end
        end

        post 'Registrar un aeropuerto' do
            tags 'Endpoints de Aeropuertos'
            produces 'application/json'
            consumes 'application/json'
            parameter name: :airport_params, in: :body, schema: {
              type: :object,
              properties: {
                city: { type: :string, example: 'Santiago' },
                name: { type: :string, example: 'Arturo Merino Benitez International Airport' }
              },
              required: %w[city name]
            }
      
            response '201', 'Registra un nuevo vuelo con éxito' do
              let(:airport_params) { { city: 'Lima', name: 'Jorge Chávez International Airport'} }
              run_test!
            end
        end

    end

    path '/airports/{id}' do
        get 'Obtener un aeropuerto' do
            tags 'Endpoints de Aeropuertos'
            produces 'application/json'
            parameter name: :id, in: :path, required: true
      
            response '200', 'Retorna el aeropuerto con éxito' do
              let(:id) { @scl.id }
              run_test!
            end
      
            response '404', 'Aeropuerto no encontrado' do
              let(:id) { 0 }
              run_test!
            end
        end

        patch 'Modificar un aeropuerto' do
            tags 'Endpoints de Aeropuertos'
            produces 'application/json'
            consumes 'application/json'
            parameter name: :id, in: :path, required: true
            parameter name: :airport_params, in: :body, schema: {
              type: :object,
              properties: {
                city: { type: :string, example: 'SCL-LIM' },
                name: { type: :string, example: '2020-01-01' }
              }
            }
      
            response '202', 'Modifica al aeropuerto con éxito' do
              let(:airport_params) { { city: 'Lim' } }
              let(:id) { @scl.id }
              run_test!
            end
      
            response '404', 'Vuelo no encontrado' do
              let(:airport_params) { { city: 'Lim'} }
              let(:id) { 0 }
              run_test!
            end
        end

    end
end
    