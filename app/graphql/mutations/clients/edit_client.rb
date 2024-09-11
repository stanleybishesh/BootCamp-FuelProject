class Mutations::Clients::EditClient < Mutations::BaseMutation
  argument :client_id, ID, required: true
  argument :client_info, Types::InputObjects::ClientInputType, required: true

  field :client, Types::Clients::ClientType, null: false
  field :errors, [ String ], null: true

  def resolve(client_id:, client_info:)
    begin
      client_service = ::Clients::ClientService.new(client_info.to_h.merge(current_user: current_user, cliend_id: client_id)).execute_edit_client
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
