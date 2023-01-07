class User < ApplicationRecord

  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  before_validation :strip_extranous_spaces
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }

  private

  def strip_extranous_spaces
    self.name = name&.strip
    self.email = email&.strip
  end
end
