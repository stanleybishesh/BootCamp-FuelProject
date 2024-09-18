module Resolvers
  module Transports
    class TransportVehicleTypeResolver < BaseResolver
      type [ Types::Transports::TransportType ], null: false

      argument :vehicle_type, Types::Transports::VehicleType, required: true


      def resolve(vehicle_type:)
        transport_service = ::Transports::TransportService.new(current_user: current_user).execute_get_transports_by_vehicle_type(vehicle_type)

        if transport_service.success?
          transport_service.transports
        else
          raise GraphQL::ExecutionError, transport_service.errors
        end
      end
    end
  end
end
