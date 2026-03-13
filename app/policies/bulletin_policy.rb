# app/policies/bulletin_policy.rb
class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && user_is_owner?
  end

  def new?
    create?
  end

  def edit?
    user.present? && (user_is_owner? || user.admin?)
  end

  def update?
    user.present? && (user_is_owner? || user.admin?)
  end

  def destroy?
    user.present? && (user_is_owner? || user.admin?)
  end

  def to_moderate?
    user.present? && (user_is_owner? || user.admin?)
  end

  def on_moderate?
    user.present? && user.admin?
  end

  def reject?
    user.present? && user.admin?
  end

  def publish?
    user.present? && user.admin?
  end

  def archive?
    user.present? && (user_is_owner? || user.admin?)
  end

  private

  def user_is_owner?
    record.user == user
  end
end
