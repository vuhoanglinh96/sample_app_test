class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  attr_reader :remember_token, :activation_token, :reset_token

  has_many :microposts, dependent: :destroy

  has_secure_password
  validates :email, format: {with: VALID_EMAIL_REGEX},
    presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.validates.email.maximum}
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.validates.password.minimum}
  validates :name, presence: true,
    length: {maximum: Settings.validates.username.maximum}

  before_save :email_downcase
  before_create :create_activation_digest

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def current_user? user
    self == user
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def create_reset_digest
    @reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def feed
    microposts
  end

  private

  def email_downcase
    email.downcase!
  end
end
