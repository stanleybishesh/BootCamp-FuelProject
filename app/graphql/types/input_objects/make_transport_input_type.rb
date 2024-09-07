module Types
  module InputObjects
    class MakeTransportInputType < BaseInputObject
      argument :name, String, required: true
      argument :status, Types::Transports::TransportStatusType, required: true
      # argument :tenant_id, ID, required: true
      argument :vehicle_type, Types::Transports::VehicleType, required: true
    end
  end
end
