module Resolvers
  module Transports
    class TransportResolver < BaseResolver
      type [ Types::Transports::TransportType ], null: false

      def resolve
        begin
          transport_service = ::Transports::TransportService.new(current_user: current_user).execute_get_all_transport

          if transport_service.success?
            transport_service.transports
          else
            raise GraphQL::ExecutionError, transport_service.errors
          end
        rescue GraphQL::ExecutionError => err
          raise GraphQL::ExecutionError, err.message
        end
      end
    end
  end
end
