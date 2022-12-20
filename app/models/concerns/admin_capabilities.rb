module AdminCapabilities
  def admin_capabilities(user)
    # Can manage every object on the platform
    can :manage, :all
    #
    # # except services, which can only be updated by it assigned operator
    # cannot :update, Service
    # can [:update, :review], Service, operator_id: user.id
  end
end