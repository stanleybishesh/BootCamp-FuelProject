class Mutations::Venues::CreateVenue < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :name, String, required: true

  field :venue, Types::Venues::VenueType, null: true
  field :message, String, null: true
  field :errors, [ String ], null: true

  def resolve(client_id:, name:)
    begin
      if current_user
        venue_service = ::Venues::VenueService.new(client_id: client_id, name: name).execute_create_venue
        if venue_service.success?
          {
            venue: venue_service.venue,
            message: "Venue created successfully",
            errors: []
          }
        else
          {
            venue: nil,
            message: "Venue failed to create",
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
        message: "Venue failed to create",
        errors: [ err.message ]
      }
    end
  end
end
