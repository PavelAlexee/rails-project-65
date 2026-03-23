class Bulletin < ApplicationRecord
  include AASM

  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }

  belongs_to :category
  belongs_to :user
  has_one_attached :image

  scope :recent, -> { where(state: "published").order(created_at: :desc) }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end
    event :archive do
      transitions from: [ :draft, :under_moderation, :published, :rejected ], to: :archived
    end
    event :reject do
      transitions from: :under_moderation, to: :rejected
    end
    event :publish do
      transitions from: :under_moderation, to: :published
    end
  end

  private

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "created_at", "description", "id", "state", "title", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category", "image_attachment", "image_blob", "user" ]
  end
end
