class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user_is_owner?
  end

  def new?
    create?
  end

  def edit?
    user_is_owner? || user.admin?
  end

  def update?
    user_is_owner? || user.admin?
  end

  def destroy?
    user_is_owner? || user.admin?
  end

  private

  def user_is_owner?
    record.user == user
  end
end
