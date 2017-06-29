class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :email_downcase

  has_secure_password
  validates :email, format: {with: VALID_EMAIL_REGEX},
    presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.validates.email.maximum}
  validates :password, presence: true,
    length: {minimum: Settings.validates.password.minimum}
  validates :name, presence: true,
    length: {maximum: Settings.validates.username.maximum}

  private
  def email_downcase
    email.downcase!
  end
end
