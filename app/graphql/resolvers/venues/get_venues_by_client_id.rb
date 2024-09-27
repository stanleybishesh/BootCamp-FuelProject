class Resolvers::Venues::GetVenuesByClientId < Resolvers::BaseResolver
  type [ Types::Venues::VenueType ], null: true

  argument :client_id, ID, required: true

  def resolve(client_id:)
    begin
      if current_user
        venue_service = ::Venues::VenueService.new(client_id: client_id).execute_get_venues_by_client_id
        if venue_service.success?
          venue_service.venues
        else
          raise GraphQL::ExecutionError, venue_service.errors
        end
      else
        raise GraphQL::UnauthorizedError, "User not logged in"
      end
    rescue GraphQL::UnauthorizedError => err
      raise err
    rescue GraphQL::ExecutionError => err
      raise err
    rescue StandardError => err
      raise GraphQL::ExecutionError, "An unexpected error occurred: #{err.message}"
    end
  end
end
