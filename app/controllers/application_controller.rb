require 'rest-client'
require 'json'

class ApplicationController < ActionController::API

  private

  def encode_token(payload)
    JWT.encode(payload, secret, algorithm)
  end


  def login_user(username, password)
    user = User.find_by(username: username)
    if user && user.authenticate(password)
      user
    else
      raise AuthError
    end
  end


  def decode_token # removed argument since token will always be found in Auth headers
    if auth_header # ensures token exists in header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, secret, true, { algorithm: algorithm })
      rescue JWT::DecodeError
        nil
      end
    end
  end


  def logged_in?
    !!current_user
  end


  def authorized
    render json: {error: "Must be logged in to view content"} unless logged_in?
  end

  def current_user
    if decode_token() #ensures Authorization token exists
      user_id = decode_token[0]['user_id'] #[{ "user_id"=>"2" }, { "alg"=>"HS256" }]
      @user = User.find_by(id: user_id)
    else
      nil
    end
  end


  def auth_header
    request.headers['Authorization']
  end


  def secret
    Rails.application.secrets.secret_key_base # replaced 'placeholder' with actual secret key
  end


  def algorithm
    'HS256'
  end


  class AuthError < StandardError
    def initialize(message="Invalid User or password")
      super
    end
  end


end
