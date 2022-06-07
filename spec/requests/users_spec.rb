require 'swagger_helper'

RSpec.describe 'users', type: :request do
  before do
    @user = User.create(name: 'John',
                        lastname: 'Doe',
                        username: 'ohn@uc.cl',
                        password_digest: '123456',
                        role: 2)
  end
  path '/users' do
    get 'Obtener los usuarios' do
      tags 'Endpoints de Usuarios'
      produces 'application/json'

      response '200', 'Retorna el listado de usuarios con éxito' do
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
          password_digest: { type: :string, example: '123456' },
          role: { type: :integer, example: 2 }
        },
        required: %w[name last_name username password_digest role]
      }

      response '201', 'Registra un nuevo usuario con éxito' do
        let(:user_params) { { name: 'John', lastname: 'Doe', username: 'John@uc.cl', password_digest: '123456', role: 2 } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Obtener un usuarios' do
      tags 'Endpoints de Usuarios'
      produces 'application/json'
      parameter name: :id, in: :path, required: true

      response '200', 'Retorna el usuario con éxito' do
        let(:id) { @user.id }
        run_test!
      end

      response '404', 'Usuario no encontrado' do
        let(:id) { 0 }
        run_test!
      end
    end

    patch 'Modificar un usuario' do
      tags 'Endpoints de Usuarios'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, required: true
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'John2' },
          lastname: { type: :string, example: 'Doe2' },
          username: { type: :string, example: 'Jonh2@uc.cl' },
          password_digest: { type: :string, example: '12345622222' },
          role: { type: :integer, example: 2 }
        }
      }

      response '202', 'Modifica al usuario con éxito' do
        let(:user_params) { { name: 'New', lastname: 'New' } }
        let(:id) { @user.id }
        run_test!
      end

      response '404', 'Usuario no encontrado' do
        let(:user_params) { { name: 'New', lastname: 'New' } }
        let(:id) { 0 }
        run_test!
      end
    end
  end
end
