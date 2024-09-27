class Mutations::Venues::DeleteVenue < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :venue_id, ID, required: true

  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(client_id:, venue_id:)
    begin
      if current_user
        venue_service = ::Venues::VenueService.new(client_id: client_id, venue_id: venue_id).execute_delete_venue
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
      else
        {
          message: "You are not authorized to perform this action.",
          errors: [ "User not logged in" ]
        }
      end
    rescue StandardError => err
      {
        message: "Venue failed to edit",
        errors: [ err.message ]
      }
    end
  end
end
