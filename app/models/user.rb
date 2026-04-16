# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :github_uid, presence: true, uniqueness: true

  has_many :bulletins, dependent: :destroy

  def admin?
    admin
  end
end
