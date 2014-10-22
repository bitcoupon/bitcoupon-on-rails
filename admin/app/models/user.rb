require_dependency '../bitcoupon/api/bitcoin_call'

# User
class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, on: :create
  validates :password, length: { minimum: 8 }

  # Returns true if user has set password
  def password?
    !password_digest.blank?
  end

  def generate_keys
    create_private_key = bitcoin.new.generate_private_key
    return_private_key = bitcoin.new.generate_private_key
  end
end
