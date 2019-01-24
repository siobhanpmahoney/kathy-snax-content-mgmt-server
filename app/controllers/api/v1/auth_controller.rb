class Api::V1::AuthController < ApplicationController
  require 'securerandom'

  def login
    
    user = User.find_by(username: user_params[:username])
    puts "\n"
    puts "in auth#login - user: #{user}"
    if user && user.authenticate(user_params[:password])
      token = encode_token({ user_id: user.id })
      puts "\n"
      puts "in auth#login - user: #{token}"
      j = { user: user, token: token }
      puts "\n"
      puts "in auth#login - json:"
      puts j
      render json: { user: user, token: token }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  # def login
  #
  #   begin
  #     @user = login_user(params[:username], params[:password])
  #
  #     if @user
  #
  #       @token = encode_token({ 'user_id': @user.id })
  #       render json: {
  #         id: @user.id,
  #         username: @user.username,
  #         token: @token
  #       }
  #     else
  #       render json: { message: 'Invalid username or password' }, status: :unauthorized
  #     end
  #   rescue AuthError => e
  #     render json: { error: e.message }, status: 401
  #   end
  # end


  def signup
    @user = User.new(user_params)

    if @user.save
      begin
        user = login_user(user_params[:username], user_params[:password])
        render json: {
          id: @user.id,
          username: @user.username,
          token: encode_token({'user_id': @user.id})
        }
      rescue AuthError => e
        render json: { error: "Invalid Passwords"}, status: 401
      end
    else
      render json: { error: "Need all info correct to sign up" }
    end
  end



  def currentUser

    @user = current_user
    puts "\n"
    puts "in auth#currentUser - @user: #{@user}"
    if @user
      render json: {
        id: @user.id,
        username: @user.username
      }
    else
      render json: nil
    end
  end




  private


  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end


end
