# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def to_moderate?
    update?
  end

  def archive?
    update?
  end

  private

  def user_is_owner?
    record.user == user
  end
end
