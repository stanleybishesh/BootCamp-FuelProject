class Resolvers::Venues::GetVenuesByClientId < Resolvers::BaseResolver
  type [ Types::Venues::VenueType ], null: false

  argument :client_id, ID, required: true

  def resolve(client_id:)
    begin
      venue_service = ::Venues::VenueService.new(client_id: client_id, current_user: current_user).execute_get_venues_by_client_id
      if venue_service.success?
        venue_service.venues
      else
        raise GraphQL::ExecutionError, venue_service.errors
      end
    rescue GraphQL::ExecutionError => err
      raise GraphQL::ExecutionError, err.message
    end
  end
end
