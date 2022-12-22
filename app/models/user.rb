class User < ApplicationRecord
  has_secure_password # password should be deleted after digestion
  has_secure_token :auth_token, length: 36

  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :posts

  def info
    "#{email} - #{admin? ? 'Admin' : 'Regular'}"
  end

  def self.auth_by_mail_and_pass(email, password)
    user = User.find_by(email: email)
    return nil unless user.present?
    if (user.authenticate(password))
      user.regenerate_auth_token
      user
    end
  end
end
