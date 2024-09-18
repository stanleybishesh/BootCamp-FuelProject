module Mutations
  module Transports
    class UpdateTransport < BaseMutation
      argument :transport_id, ID, required: true
      argument :transport_info, Types::InputObjects::MakeTransportInputType, required: true

      field :transport, Types::Transports::TransportType, null: true
      field :errors, [ String ], null: false
      field :message, String, null: false

      def resolve(transport_id:, transport_info:)
        transport_service = ::Transports::TransportService.new(transport_id: transport_id, transport_info: transport_info.to_h, current_user: current_user).execute_update_transport
        if transport_service.success?
          {
            transport: transport_service.transport,
            errors: [],
            message: "Transport updated successfully"
          }
        else
          {
            transport: nil,
            errors: [ transport_service.errors ],
            message: "Transport update failed"
          }
        end
      end
    end
  end
end
