# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'users', type: :request do
  before do
    @user = User.create(name: 'John',
                        lastname: 'Doe',
                        username: 'ohn@uc.cl',
                        password: '123456',
                        role: 2)
  end
  path '/users' do
    get 'Obtener los usuarios' do
      tags 'Endpoints de Usuarios'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'Retorna el listado de usuarios con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        run_test!
      end
    end

    post 'Registrar un usuario' do
      tags 'Endpoints de Usuarios'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'John' },
          lastname: { type: :string, example: 'Doe' },
          username: { type: :string, example: 'Jonh@uc.cl' },
          password: { type: :string, example: '123456' },
          role: { type: :integer, example: 2 }
        },
        required: %w[name last_name username password role]
      }

      response '201', 'Registra un nuevo usuario con éxito' do
        let(:user_params) { { name: 'John', lastname: 'Doe', username: 'John@uc.cl', password: '123456', role: 2 } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Obtener un usuarios' do
      tags 'Endpoints de Usuarios'
      produces 'application/json'
      parameter name: :id, in: :path, required: true
      security [bearerAuth: []]

      response '200', 'Retorna el usuario con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { @user.id }
        run_test!
      end

      response '404', 'Usuario no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:id) { @user.id }
        run_test!
      end
    end

    patch 'Modificar un usuario' do
      tags 'Endpoints de Usuarios'
      produces 'application/json'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, required: true
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'John2' },
          lastname: { type: :string, example: 'Doe2' },
          username: { type: :string, example: 'Jonh2@uc.cl' },
          password: { type: :string, example: '12345622222' },
          role: { type: :integer, example: 2 }
        }
      }

      response '202', 'Modifica al usuario con éxito' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:user_params) { { name: 'New', lastname: 'New' } }
        let(:id) { @user.id }
        run_test!
      end

      response '404', 'Usuario no encontrado' do
        let(:Authorization) { "Bearer #{AuthenticationTokenService.generate_token(@user.id)}" }
        let(:user_params) { { name: 'New', lastname: 'New' } }
        let(:id) { 0 }
        run_test!
      end

      response '401', 'Error en validación de Token' do
        let(:Authorization) { 'Bearer ' }
        let(:user_params) { { name: 'New', lastname: 'New' } }
        let(:id) { @user.id }
        run_test!
      end
    end
  end
end
