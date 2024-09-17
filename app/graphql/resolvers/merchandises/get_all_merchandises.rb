class Resolvers::Merchandises::GetAllMerchandises < Resolvers::BaseResolver
  type [ Types::Merchandises::MerchandiseType ], null: false

  def resolve
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        Merchandise.all
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
