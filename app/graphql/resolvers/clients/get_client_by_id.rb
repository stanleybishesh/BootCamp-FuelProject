class Resolvers::Clients::GetClientById < Resolvers::BaseResolver
  type Types::Clients::ClientType, null: false

  argument :client_id, ID, required: true

  def resolve(client_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        membership = Membership.find_by(client_id: client_id)
        Client.find(membership.client_id)
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
