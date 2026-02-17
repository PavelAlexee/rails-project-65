class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :github_uid, presence: true, uniqueness: true

  has_many :bulletins, dependent: :destroy
end
