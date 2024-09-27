class Mutations::Venues::EditVenue < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :venue_id, ID, required: true
  argument :name, String, required: true

  field :venue, Types::Venues::VenueType, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(client_id:, venue_id:, name:)
    begin
      if current_user
        venue_service = ::Venues::VenueService.new(client_id: client_id, venue_id: venue_id, name: name).execute_edit_venue
        if venue_service.success?
          {
            venue: venue_service.venue,
            message: "Venue updated successfully",
            errors: []
          }
        else
          {
            venue: nil,
            message: "Venue failed to edit",
            errors: [ venue_service.errors ]
          }
        end
      else
        {
          venue: nil,
          message: "You are not authorized to perform this action.",
          errors: [ "User not logged in" ]
        }
      end
    rescue StandardError => err
      {
        venue: nil,
        message: "Venue failed to edit",
        errors: [ err.message ]
      }
    end
  end
end
