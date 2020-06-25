class User < ApplicationRecord
  attr_accessor :remember_token, :verification_token, :reset_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_validation do
    self.email = email.downcase
    cpf = CPF.new(self.cpf)
    self.cpf = cpf.stripped
  end
  before_create :generate_verification_digest

  has_secure_password

  belongs_to :role
  belongs_to :address
  has_one :admin, dependent: :destroy
  has_one :reviewer, dependent: :destroy
  has_one :student, dependent: :destroy

  accepts_nested_attributes_for :student
  accepts_nested_attributes_for :reviewer
  accepts_nested_attributes_for :admin

  validates :email, :username, :name, :birth_date, :cpf, :role, :address, presence: true
  validates :email, :cpf, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :username, length: { minimum: 5, maximum: 16 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :cpf_format

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.generate_digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def generate_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.generate_digest(reset_token))
    update_attribute(:reset_at, DateTime.current)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def send_verification_email
    UserMailer.account_verification(self).deliver_now
  end

  def verify
    update_attribute(:verified, true)
    update_attribute(:verified_at, Time.current)
  end

  def remembered?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest) == remember_token
  end

  def verified?(verification_token)
    return false if verification_digest.nil?
    BCrypt::Password.new(verification_digest) == verification_token
  end

  def resetable?(reset_token)
    return false if reset_token.nil?
    BCrypt::Password.new(reset_digest) == reset_token
  end

  def password_reset_expired?
    reset_at < 2.hours.ago
  end

  # Checks if the user is an Admin
  def admin?
    role_id == 1
  end

  # Checks if the user is a Reviewer
  def reviewer?
    role_id == 2
  end

  # Checks if the user is a Student
  def student?
    role_id == 3
  end

  private

  require "cpf_cnpj"

  # Generates a verification token and its corresponding digest
  def generate_verification_digest
    # Generates a new verification token
    self.verification_token = User.new_token
    # Fills the verification column with the digest of the generated token
    self.verification_digest = User.generate_digest(verification_token)
  end

  # Validates CPF format
  def cpf_format
    # Checks if the given CPF is valid
    errors.add(:cpf, "is invalid") unless CPF.valid?(self.cpf, strict: true)
  end

  # Generates a random token
  def User.new_token
    # Returns the generated random alphanumeric token
    SecureRandom.alphanumeric(37)
  end

  # Generates a BCrypt digest
  def User.generate_digest(plain_text)
    # Generates the digest
    BCrypt::Password.create(plain_text)
  end
end
