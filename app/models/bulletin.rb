class Bulletin < ApplicationRecord
  has_one_attached :image

  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }

  belongs_to :category
  belongs_to :user
end
