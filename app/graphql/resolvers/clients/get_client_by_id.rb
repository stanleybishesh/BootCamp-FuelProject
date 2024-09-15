class Resolvers::Clients::GetClientById < Resolvers::BaseResolver
  type Types::Clients::ClientType, null: false

  argument :client_id, ID, required: true

  def resolve(client_id:)
    begin
      client_service = ::Clients::ClientService.new(current_user: current_user, client_id: client_id).execute_get_client_by_id
      if client_service.success?
        client_service.client
      else
        raise GraphQL::ExecutionError, client_service.errors
      end
    rescue GraphQL::ExecutionError => err
      raise GraphQL::ExecutionError, err.message
    end
  end
end
