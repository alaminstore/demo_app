class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]

  def show
    render json: UserService.show(params[:id])
  end

  def create
    result = UserService.create(user_params)

    if result[:ok]
      render json: result[:user], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :age, :bio, :is_active)
  end
end
