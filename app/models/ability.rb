class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
    else
      can :read, Article, status: 'public'
      can :read, Article, status: 'archived', user_id: user.id


      # cannot :manage, :all do |resource|
      #   raise CanCan::AccessDenied
      # end
    end
  end
end