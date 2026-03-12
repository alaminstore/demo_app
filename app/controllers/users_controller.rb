class UsersController < ApplicationController
  def show
    render json: Users::Show.call(params[:id])
  end
end
