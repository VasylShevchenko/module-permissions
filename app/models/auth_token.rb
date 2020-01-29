class AuthToken < ApplicationRecord
  belongs_to :user

  validates :encrypted_token, presence: true, uniqueness: true

  before_validation :generate_token!

  def token
    self.class.decrypt(encrypted_token)
  end

  def self.find_by_token(token)
    find_by(encrypted_token: encrypt(token)) if token.present?
  end

  private

  def self.encrypt(token)
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt
    cipher.key = Rails.application.credentials.auth_secret

    data = cipher.update(token) + cipher.final

    Base64.strict_encode64(data)
  end

  def self.decrypt(encrypted_token)
    data = Base64.strict_decode64(encrypted_token)

    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.decrypt
    cipher.key = Rails.application.credentials.auth_secret

    cipher.update(data) + cipher.final
  end

  def generate_token!
    loop do
      token = Devise.friendly_token
      self.encrypted_token = self.class.encrypt(token)

      break unless self.class.exists?(encrypted_token: encrypted_token)
    end
  end

end
