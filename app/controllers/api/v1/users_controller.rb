class Api::V1::UsersController < ApplicationController
  # before_action :authorized

  def index
    @users = User.all
    render json: @users
  end

  def create

      @user = User.new(user_params)
      if @user.save
        @token = encode_token(user_id: @user.id) #issues token when user is registered
        render json: @user, status: 201
      else
        render json: {error:"Error, User not saved"}, status: :unauthorized
      end
    else
      @user = User.find_by(username: user_params["username"])
      render json: @user, status: 201
      # render json: {user: @user, token: @token}, serialzer: UserSerializer, status: 201

  end



  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      render json: @user
    else
      render json: {error: @user.errors.full_messages}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: {message:"User Deleted"}
  end



  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
