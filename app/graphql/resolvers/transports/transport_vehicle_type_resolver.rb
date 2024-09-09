module Resolvers
  module Transports
    class TransportVehicleTypeResolver < BaseResolver
      type [ Types::Transports::TransportType ], null: false

      argument :vehicle_type, Types::Transports::VehicleType, required: true


      def resolve(vehicle_type:)
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            Transport.where(vehicle_type: vehicle_type)
          end
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
