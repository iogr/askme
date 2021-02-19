require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  EMAIL_VALID_MASK = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  USERNAME_VALID_MASK = /\A\w+\z/
  COLOR_VALID_MASK = /\A#\h{3}{1,2}\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy
  has_many :authored_questions, class_name: 'Question', foreign_key: :author_id, dependent: :nullify

  before_validation :username_to_downcase
  before_save :encrypt_password

  # username validations
  validates :username,
            presence: true,
            length: { maximum: 40 },
            format: { with: USERNAME_VALID_MASK }

  # email validations
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: EMAIL_VALID_MASK }

  validates :password,
            presence: true,
            confirmation: true,
            on: :create

  # account color validation
  validates :color, format: { with: COLOR_VALID_MASK }

  def self.authenticate(email, password)
      user = find_by(email: email)

    return nil unless user.present?
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    return user if user.password_hash == hashed_password
    nil
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def username_to_downcase
    username&.downcase!
  end
end
