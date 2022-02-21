class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user_loggedin?
  end

  alias create? new?

  def edit?
    record.user == user
  end

  alias update? edit?
  alias destroy? edit?
end
