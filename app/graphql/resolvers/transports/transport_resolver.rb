module Resolvers
  module Transports
    class TransportResolver < BaseResolver
      type [ Types::Transports::TransportType ], null: false

      def resolve
        begin
          if current_user
            transport_service = ::Transports::TransportService.new.execute_get_all_transport
            if transport_service.success?
              transport_service.transports
            else
              raise GraphQL::ExecutionError, transport_service.errors
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
  end
end
