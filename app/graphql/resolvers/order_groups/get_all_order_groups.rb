class Resolvers::OrderGroups::GetAllOrderGroups < Resolvers::BaseResolver
  type [ Types::OrderGroups::OrderGroupType ], null: false

  def resolve
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        OrderGroup.all
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
