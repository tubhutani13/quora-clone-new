class User < ApplicationRecord
  enum role: {
         "user" => 0,
         "admin" => 1,
       }

  has_secure_password
  has_one_attached :profile_picture, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :mini, resize_to_limit: [40, 40]
  end
  
  before_create :confirmation_token
  after_create_commit :send_confirmation_email
  before_save :downcase_email

  validates :name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_set?

  def verified?
    verified_at.present?
  end

  def email_activate
    update(email_confirm_token: nil, verified_at: Time.current)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.now
    save
    UserMailer.forgot_password(id).deliver
  end

  private

  def confirmation_token
    if self.email_confirm_token.blank?
      self.email_confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def password_set?
    return !(self.password.blank? && !self.new_record?)
  end

  def send_confirmation_email
    UserMailer.registration_confirmation(id).deliver_later
  end

  def downcase_email
    self.email = email.downcase
  end
end
