class Resolvers::Merchandises::GetMerchandiseByCategory < Resolvers::BaseResolver
  argument :merchandise_category_id, ID, required: true
  type [ Types::Merchandises::MerchandiseType ], null: false

  def resolve(merchandise_category_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        MerchandiseCategory.find(merchandise_category_id).merchandises
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
