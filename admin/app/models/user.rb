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
    self.create_private_key = bitcoin.new.generate_private_key.chomp
    self.return_private_key = bitcoin.new.generate_private_key.chomp

    self.create_address = bitcoin.new.generate_address create_private_key.chomp
    self.return_address = bitcoin.new.generate_address return_private_key.chomp
  end

  def output_history_request(private_key)
    if self[:output_history_request].blank?
      self[:output_history_request] = bitcoin.new
                                        .generate_output_history_request(
                                          private_key)
    else
      self[:output_history_request]
    end
  end

  private

  def bitcoin
    Bitcoupon::Api::BitcoinCall
  end
end
