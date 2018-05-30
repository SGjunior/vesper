class SquadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    # add policy, if his logged in or not
    true
  end

  def create?
    true
  end

  def show?
    true
  end
end
