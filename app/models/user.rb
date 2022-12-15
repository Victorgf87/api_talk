class User < ApplicationRecord
  has_secure_password # password should be deleted after digestion
  has_secure_token

  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def info
    "#{email} - #{admin? ? 'Admin' : 'Regular'}"
  end
end
