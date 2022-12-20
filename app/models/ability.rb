# frozen_string_literal: true

class Ability
  include CanCan::Ability
  include AdminCapabilities
  include UserCapabilities

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    return unless user
    if user.admin?
      admin_capabilities(user)
    else
      user_capabilities(user)
    end

    # if user.is_a?(User)
    #   user_capabilities(user)
    # elsif user.is_a?(Doer)
    #   doer_capabilities(user)
    # elsif user.is_a?(Operator)
    #   # Can manage every object on the platform
    #   can :manage, :all
    #
    #   # except services, which can only be updated by it assigned operator
    #   cannot :update, Service
    #   can [:update, :review], Service, operator_id: user.id
    # end
  end
end
