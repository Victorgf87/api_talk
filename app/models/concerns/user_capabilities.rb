module UserCapabilities
  def user_capabilities(user)
    # # Can manage every object on the platform
    # can :manage, :all
    #
    # # except services, which can only be updated by it assigned operator
    # cannot :update, Service
    # can [:update, :review], Service, operator_id: user.id
  end
end

# module UsersAbilities
#
#   def user_capabilities(user)
#     regular_abilities(user)
#     return if user.regular?
#
#     admin_abilities(user)
#     return if user.admin?
#
#     superadmin_abilities(user)
#   end
#
#   private
#
#   def regular_abilities(user)
#     can(:create, CompanyAggrupation) { user.user_vinculations.empty? }
#
#     # We dont want user with null user_vinculations to have access to resources with
#     # null parents
#     return if user.user_vinculations.empty?
#
#     # Users permissions
#     can(:manage, User, id: user.id)
#
#     can([:read, :update], CompanyAggrupation) { |company_aggrupation| vinculated_to_ancestor?(user, company_aggrupation) }
#
#     can(:read, Company)   { |resource| vinculated_to_ancestor?(user, resource) }
#     can(:read, Group)     { |resource| vinculated_to_ancestor?(user, resource) }
#     can(:read, Space)     { |resource| vinculated_to_ancestor?(user, resource) }
#     can(:read, Appliance) { |resource| vinculated_to_ancestor?(user, resource) }
#     can(:read, Visit)     { |resource| vinculated_to_ancestor?(user, resource.space) }
#     can(:read, Invoice)   { |resource| resource.finished? && vinculated_to_ancestor?(user, resource.invoiceable) }
#
#     can([:read, :meta, :update], Service, space_id: user.children[:spaces])
#     can :read, Budget, service: { space_id: user.children[:spaces] }, status: :finished
#     can [:update, :select], Budget do |budget|
#       service = budget.service
#
#       user.children[:spaces].include?(service.space.id) &&
#         service.status == :acceptance_budget_pending &&
#         budget.status == :finished &&
#         budget.pricelist_total_price <= [user.real_budget_limit, service.space.default_nte].min
#     end
#
#     can(:create, Comment) { |comment| vinculated_to_ancestor?(user, comment.service.space) }
#
#     can :read, Pricelist, company_aggrupation_id: user.company_aggrupations.first&.id
#
#     can :get_pricelist_in_budget, Budget
#   end
#
#   def admin_abilities(user)
#     can(:manage, User) { |resource| vinculated_to_ancestor?(user, resource) }
#
#     can(:manage, Company)   { |resource| vinculated_to_ancestor?(user, resource) }
#     can(:manage, Group)     { |resource| vinculated_to_ancestor?(user, resource) }
#     can(:manage, Space)     { |resource| vinculated_to_ancestor?(user, resource) }
#     can(:manage, Appliance) { |resource| vinculated_to_ancestor?(user, resource) }
#
#     can(:custom_nte, Service)
#
#     can(:manage, Pricelist, company_aggrupation_id: user.company_aggrupation&.id)
#
#     can [:update, :select], Budget do |budget|
#       service = budget.service
#
#       user.children[:spaces].include?(service.space.id) &&
#         service.status == :acceptance_budget_pending &&
#         budget.status == :finished &&
#         budget.pricelist_total_price <= [user.real_budget_limit, service.space.default_nte].max
#     end
#   end
#
#   def superadmin_abilities(user)
#     can(:superadmin, User) { |resource| vinculated_to_ancestor?(user, resource) }
#
#     can(:disable_nte, Service)
#
#     can(
#       [:update, :select],
#       Budget,
#       status: :finished,
#       service: {
#         status: :acceptance_budget_pending, space_id: user.children[:spaces]
#       }
#     )
#   end
#
# end