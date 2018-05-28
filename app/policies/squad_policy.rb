class SquadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    true
  end

  def show?
    # TODO : only squad member can see the show page
    true
  end
end
