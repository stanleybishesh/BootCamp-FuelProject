class Mutations::Venues::DeleteVenue < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :venue_id, ID, required: true

  field :message, String, null: true

  def resolve(client_id:, venue_id:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        membership = Membership.find_by(client_id: client_id)
        raise GraphQL::ExecutionError, "Client not found in this tenant" if membership.nil?
        client = Client.find(membership.client_id)
        venue = client.venues.find(venue_id)
        if venue.destroy
          {
            message: "Venue successfully deleted"
          }
        else
          {
            message: "Venue failed to delete"
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
