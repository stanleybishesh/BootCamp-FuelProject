module Mutations
  module Transports
    class CreateTransport < BaseMutation
      argument :transport_info, Types::InputObjects::MakeTransportInputType, required: true

      field :transport, Types::Transports::TransportType, null: true
      field :errors, [ String ], null: true
      field :message, String, null: true

      def resolve(transport_info:)
        begin
          if current_user
            transport_service = ::Transports::TransportService.new(transport_info.to_h).execute_create_transport
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
          else
            {
              transport: nil,
              errors: [ "User not logged in" ],
              message: "You are not authorized to perform this action."
            }
          end
        rescue StandardError => err
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
