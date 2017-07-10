class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  scope :desc, ->{order created_at: :desc}
  scope :feed_id, -> id do
    where "user_id IN (SELECT followed_id FROM relationships
      WHERE follower_id = :id) OR user_id = :id", id: id
  end

  mount_uploader :picture, PictureUploader

  delegate :name, to: :user, allow_nil: true

  private

  def picture_size
    return if picture.size < 5.megabytes
    errors.add :picture, I18n.t(".image_size")
  end
end
