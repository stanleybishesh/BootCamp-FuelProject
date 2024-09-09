class Resolvers::Venues::GetVenuesByClientId < Resolvers::BaseResolver
  type [ Types::Venues::VenueType ], null: false

  argument :client_id, ID, required: true

  def resolve(client_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        membership = Membership.find_by(client_id: client_id)
        raise GraphQL::ExecutionError, "Client not found in this tenant" if membership.nil?
        client = Client.find(membership.client_id)
        client.venues
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
