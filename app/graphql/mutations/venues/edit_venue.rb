class Mutations::Venues::EditVenue < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :venue_id, ID, required: true
  argument :name, String, required: true

  field :venue, Types::Venues::VenueType, null: false
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(client_id:, venue_id:, name:)
    begin
      venue_service = ::Venues::VenueService.new(client_id: client_id, venue_id: venue_id, name: name, current_user: current_user).execute_edit_venue
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
    rescue GraphQL::ExecutionError => err
      {
        venue: nil,
        message: "Venue failed to edit",
        errors: [ err.message ]
      }
    end
  end
end
