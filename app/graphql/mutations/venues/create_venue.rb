class Mutations::Venues::CreateVenue < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :name, String, required: true

  field :venue, Types::Venues::VenueType, null: false
  field :message, String, null: true

  def resolve(client_id:, name:)
    user = current_user
    if user
      ActsAsTenant.with_tenant(user.tenant) do
        membership = Membership.find_by(client_id: client_id)
        raise GraphQL::ExecutionError, "Client not found in this tenant" if membership.nil?
        client = Client.find(membership.client_id)
        venue = client.venues.build(name: name, client_id: client_id)
        if venue.save
          {
            venue: venue,
            message: "Venue successfully created"
          }
        else
          {
            venue: nil,
            message: "Venue failed to create"
          }
        end
      end
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
