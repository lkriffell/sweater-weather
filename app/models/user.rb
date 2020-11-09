class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true, presence: true
  validates :password, presence: true

  def self.generate_api_key
    SecureRandom.base58(24)
  end

end
