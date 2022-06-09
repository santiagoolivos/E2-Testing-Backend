# frozen_string_literal: true

# user controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  skip_before_action :authenticate_user, only: %i[create]

  # GET /users
  def index
    @users = User.all

    render json: @users, except: [:password_digest], status: :ok
  end

  # GET /users/1
  def show
    render json: { error: 'No se ha encontrado el usuario' }, status: :not_found if @user.blank?
    render json: @user, except: [:password_digest], status: :ok if @user.present?
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      render json: user, except: [:password_digest], status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    render json: { error: 'No se ha encontrado el usuario' }, status: :not_found if @user.blank?
    return unless @user.present?

    if @user.update(user_params)
      render json: @user, except: [:password_digest], status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    render json: { error: 'No se ha encontrado el usuario' }, status: :not_found if @user.blank?
    @user.destroy if @user.present?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @user = nil
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:name, :lastname, :username, :password, :role)
  end
end
