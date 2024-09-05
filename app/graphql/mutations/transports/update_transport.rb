module Mutations
  module Transports
    class UpdateTransport < BaseMutation
      argument :id, ID, required: true
      argument :transport_info, Types::InputObjects::MakeTransportInputType, required: true

      field :transport, Types::Transports::TransportType, null: true
      field :errors, [ String ], null: false
      field :message, String, null: false

      def resolve(id:, transport_info:)
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            transport = Transport.find_by(id: id)

            if transport.nil?
              raise GraphQL::ExecutionError, "Transport not found"
            end

            if transport.update(transport_info.to_h)
              {
                transport: transport,
                errors: [],
                message: "Transport updated successfully"
              }
            else
              {
                transport: nil,
                errors: transport.errors.full_messages,
                message: "Transport could not be updated"
              }
            end
          end
        else
          raise GraphQL::ExecutionError, "User not logged in"
        end
      end
    end
  end
end
