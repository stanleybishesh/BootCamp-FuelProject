class Mutations::Venues::DeleteVenue < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :venue_id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(client_id:, venue_id:)
    begin
      venue_service = ::Venues::VenueService.new(client_id: client_id, venue_id: venue_id, current_user: current_user).execute_delete_venue
      if venue_service.success?
        {
          message: "Venue deleted successfully",
          errors: []
        }
      else
        {
          message: "Venue failed to delete",
          errors: [ venue_service.errors ]
        }
      end
    rescue GraphQL::ExecutionError => err
      {
        message: "Venue failed to edit",
        errors: [ err.message ]
      }
    end
  end
end
