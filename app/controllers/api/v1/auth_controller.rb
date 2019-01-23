class Api::V1::AuthController < ApplicationController
  require 'securerandom'

  def login
    puts "\n"
    puts "\n"
    puts "at auth_controller#decode_token, line 6"
    puts "\n"
    puts "\n"
    begin
      @user = login_user(params[:username], params[:password])
      puts "user: #{@user}"
      puts "at auth_controller#decode token, USER = #{@user.id}"

      if @user
        puts "\n"
        puts "\n"
        puts "encode token?"
        
        puts "\n"
        puts "\n"
        puts "\n"
        puts "\n"
        @token = encode_token({ 'user_id': @user.id })
        puts "@token: #{@token}"
        render json: {
          username: @user.username,
          token: @token
        }
      else
        render json: { message: 'Invalid username or password' }, status: :unauthorized
      end
    rescue AuthError => e
      render json: { error: e.message }, status: 401
    end
  end


  def signup
    @user = User.new(user_params)
    puts "params"
    puts params
    puts "\n"
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
    puts "\n"
    puts "\n"
    puts "at auth_controller#currentUser, line 57"
    puts "\n"
    puts "\n"
    if user
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
