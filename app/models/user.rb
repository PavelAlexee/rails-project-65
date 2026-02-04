class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :github_uid, presence: true, uniqueness: true

  has_many :bulletins, dependent: :destroy

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
