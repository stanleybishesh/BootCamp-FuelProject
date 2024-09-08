class Resolvers::Venues::GetAllVenues < Resolvers::BaseResolver
  type [ Types::Venues::VenueType ], null: false

  def resolve
    user = current_user
    if user
      Venue.all
    else
      raise GraphQL::ExecutionError, "User not logged in"
    end
  end
end
