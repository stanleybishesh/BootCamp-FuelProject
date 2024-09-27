class Mutations::Clients::CreateClient < Mutations::BaseMutation
  argument :client_info, Types::InputObjects::ClientInputType, required: true

  field :client, Types::Clients::ClientType, null: true
  field :errors, [ String ], null: true

  def resolve(client_info:)
    begin
      if current_user
        client_service = ::Clients::ClientService.new(client_info.to_h).execute_create_client
        if client_service.success?
          {
            client: client_service.client,
            errors: []
          }
        else
          {
            client: nil,
            errors: [ client_service.errors ]
          }
        end
      else
        {
          client: nil,
          errors: [ "User not logged in" ]
        }
      end
    rescue StandardError => err
      {
        client: nil,
        errors: [ err.message ]
      }
    end
  end
end
