class User < ApplicationRecord
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end
end
