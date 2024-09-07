class Resolvers::MerchandiseCategories::GetAllMerchandiseCategories < Resolvers::BaseResolver
  type [ Types::MerchandiseCategories::MerchandiseCategoryType ], null: false

  def resolve
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        MerchandiseCategory.all
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
