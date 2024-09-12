class Resolvers::Clients::GetAllClients < Resolvers::BaseResolver
  type [ Types::Clients::ClientType ], null: false

  def resolve
    begin
      client_service = ::Clients::ClientService.new(current_user: current_user).execute_get_all_clients
      if client_service.success?
        client_service.clients
      else
        raise GraphQL::ExecutionError, client_service.errors.join(", ")
      end
    rescue GraphQL::ExecutionError => err
      raise GraphQL::ExecutionError, err.message
    end
  end
end
