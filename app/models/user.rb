# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  ROLES = %w[admin author].freeze

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: ROLES }, allow_nil: true

  def admin?
    role == "admin"
  end

  def author?
    role == "author"
  end
end
