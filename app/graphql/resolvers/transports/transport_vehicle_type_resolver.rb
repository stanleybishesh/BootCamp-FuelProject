module Resolvers
  module Transports
    class TransportVehicleTypeResolver < BaseResolver
      type [ Types::Transports::TransportType ], null: false

      argument :vehicle_type, String, required: true


      def resolve(vehicle_type:)
        Transport.where(vehicle_type: vehicle_type)
      end
    end
  end
end
