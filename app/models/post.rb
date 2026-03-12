class Post < ApplicationRecord
  # here why user not users
  # why comments not comment
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true

  before_save :set_published_at

  private

  def set_published_at
    self.published_at ||= Time.current if published?
  end
end

