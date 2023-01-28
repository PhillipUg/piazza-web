class User < ApplicationRecord

  include Authentication

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  before_validation :strip_extra_spaces
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }

  private

  def strip_extra_spaces
    self.name = name&.strip
    self.email = email&.strip
  end
end
