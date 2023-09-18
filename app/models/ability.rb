class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
    else
      can :read, :all

      cannot :manage, :all do |resource|
        raise CanCan::AccessDenied
      end
    end
  end
end