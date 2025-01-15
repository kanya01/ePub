class UserPolicy < ApplicationPolicy
  def show?
    true # Everyone can view profiles
  end

  def update?
    user == record || user.admin?
  end

  def manage?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end