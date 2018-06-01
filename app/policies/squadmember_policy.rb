class SquadmemberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def confirm_squad_member?
    record.user == user
  end
end
