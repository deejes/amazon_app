

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    # if user.is_admin?
    #   can :manage :all
    # end

    # DSL -> domain specific language, ruby code written in a certain way that looks
    #like its own language, but is acutally just ruby code

    # in this rule we're saying: the user can `manage` meaning do any action on
    # the question object if `ques.user == user` which means if the owner of
    # the question is the currently signed in user

    can :manage, Product do |prod|
      prod.user == user
    end


    # can :destroy, Answer do |ans|
    #   ans.user == user || ans.question.user == user
    # end
    # remember that this only defines the rules, you still have to enforce the
    # rules yourself by actually using those rules in the controllers and views
    # the advantage is that all of our authoization rules are in one file so we
    # only have to come and change this file when authoization rules change.


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
