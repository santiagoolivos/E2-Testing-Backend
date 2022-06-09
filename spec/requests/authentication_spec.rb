# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'authentication', type: :request do
  before do
    @user = User.create(name: 'John',
                        lastname: 'Doe',
                        username: 'John@uc.cl',
                        password: '123456',
                        role: 2)
  end
  path '/authenticate' do
    post 'Tries to Log In' do
      tags 'Authentication Endpoints'
      consumes 'application/json'
      parameter name: :login_params, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string, example: 'balamos@user.cl' },
          password: { type: :string, example: 'benja' }
        },
        required: %w[username password]
      }
      response '200', 'Successful log in' do
        let(:login_params) { { username: 'John@uc.cl', password: '123456' } }
        run_test!
      end

      response '401', 'Log in failed' do
        let(:login_params) { { username: 'john@uc.cl', password: '123123' } }
        run_test!
      end
    end
  end
end
