class Resolvers::Clients::GetAllClients < Resolvers::BaseResolver
  type [ Types::Clients::ClientType ], null: true

  def resolve
    begin
      if current_user
        client_service = ::Clients::ClientService.new.execute_get_all_clients
        if client_service.success?
          client_service.clients
        else
          raise GraphQL::ExecutionError, client_service.errors
        end
      else
        raise GraphQL::UnauthorizedError, "User not logged in"
      end
    rescue GraphQL::UnauthorizedError => err
      raise err
    rescue GraphQL::ExecutionError => err
      raise err
    rescue StandardError => err
      raise GraphQL::ExecutionError, "An unexpected error occurred: #{err.message}"
    end
  end
end
