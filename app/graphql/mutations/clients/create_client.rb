class Mutations::Clients::CreateClient < Mutations::BaseMutation
  argument :client_info, Types::InputObjects::ClientInputType, required: true

  field :client, Types::Clients::ClientType, null: false
  field :errors, [ String ], null: true

  def resolve(client_info:)
    begin
      client_service = ::Clients::ClientService.new(client_info.to_h.merge(current_user: current_user)).execute_create_client
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
    rescue GraphQL::ExecutionError => err
      {
        client: nil,
        errors: [ err.message ]
      }
    end
  end
end
