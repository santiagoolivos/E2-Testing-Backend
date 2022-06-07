# frozen_string_literal: true

# authentication controller
class AuthenticationController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ApiValidation::AuthenticationError, with: :handle_unauthenticated
  skip_before_action :authenticate_user

  def login
    raise ApiValidation::AuthenticationError if user.blank?
    raise ApiValidation::AuthenticationError unless user.authenticate(params.require(:password))

    # raise ActionController::ParameterMissing unless params.require(:token)

    render json: { token: AuthenticationTokenService.generate_token(user.id), user_id: user.id }
  end

  private

  def user
    @user ||= User.find_by(username: params.require(:username))
  end

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def handle_unauthenticated
    render json: { error: 'Log in failed' }, status: :unauthorized
  end
end
