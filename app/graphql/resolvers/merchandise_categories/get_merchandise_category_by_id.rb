class Resolvers::MerchandiseCategories::GetMerchandiseCategoryById < Resolvers::BaseResolver
  argument :merchandise_category_id, ID, required: true
  type Types::MerchandiseCategories::MerchandiseCategoryType, null: false

  def resolve(merchandise_category_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        MerchandiseCategory.find(merchandise_category_id)
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
