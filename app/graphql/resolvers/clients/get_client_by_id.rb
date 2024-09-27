class Resolvers::Clients::GetClientById < Resolvers::BaseResolver
  type Types::Clients::ClientType, null: true

  argument :client_id, ID, required: true

  def resolve(client_id:)
    begin
      if current_user
        client_service = ::Clients::ClientService.new(client_id: client_id).execute_get_client_by_id
        if client_service.success?
          client_service.client
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
