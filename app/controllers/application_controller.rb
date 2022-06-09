# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token
  before_action :authenticate_user

  def not_found
    render json: { error: 'not_found' }
  end

  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode_token(token)
    return head :unauthorized if user_id.blank?

    @user = User.find(user_id)
    return head :unauthorized if @user.blank?

    params[:user_id] = @user.id
  end
end
