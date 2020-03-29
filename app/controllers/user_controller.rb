class UserController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all
    render json: {status: 'SUCCESS', message: 'Loaded users', data: users}
  end

  def show
    render json: {status: 'SUCCESS', message: 'Loaded the user', data: @user}
  end

  def create
    user = User.new(user_params)
    result = user.save
    pp result
    if result
      render json: {status: 'SUCCESS', data: result}
    else
      render json: {status: 'ERROR', data: result.errors}
    end
  end

  def destroy
    @user.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @user }
  end

  def update
    if @user.update(user_params)
      render json: { status: 'SUCCESS', message: 'Updated the user', data: @user }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @user.errors }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :other)
  end
end
