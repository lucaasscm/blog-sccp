# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_one_attached :cover_image

  STATUSES = %w[draft published].freeze

  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  scope :published, -> { where(status: "published").order(id: :desc) }

  def published?
    status == "published"
  end

  def draft?
    status == "draft"
  end
end
