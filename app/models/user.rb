class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  before_validation :normalize_email
  after_create_commit :enqueue_welcome_email

  scope :active, -> { where(is_active: true) }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

  def enqueue_welcome_email
    UserWelcomeWorker.perform_async(id)
  end
end
