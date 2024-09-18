module Mutations
  module Transports
    class CreateTransport < BaseMutation
      argument :transport_info, Types::InputObjects::MakeTransportInputType, required: true

      field :transport, Types::Transports::TransportType, null: true
      field :errors, [ String ], null: false
      field :message, String, null: false

      def resolve(transport_info:)
        begin
          transport_service = ::Transports::TransportService.new({ transport_info: transport_info.to_h }.merge(current_user: current_user)).execute_create_transport
          if transport_service.success?
            {
              transport: transport_service.transport,
              errors: [],
              message: "Transport created successfully"
            }
          else
            {
              transport: nil,
              errors: [ transport_service.errors ],
              message: "Transport creation failed"
            }
          end
        rescue GraphQL::ExecutionError => err
          {
            transport: nil,
            message: "Transport failed to create",
            errors: [ err.message ]
          }
        end
      end
    end
  end
end
