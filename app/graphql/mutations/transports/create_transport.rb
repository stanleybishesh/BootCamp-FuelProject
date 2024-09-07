module Mutations
  module Transports
    class CreateTransport < BaseMutation
      argument :transport_info, Types::InputObjects::MakeTransportInputType, required: true

      field :transport, Types::Transports::TransportType, null: true
      field :errors, [ String ], null: false
      field :message, String, null: false

      def resolve(transport_info:)
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            transport_attr = transport_info.to_h

            transport = Transport.new(transport_attr)

            if transport.save
              {
                transport: transport,
                errors: [],
                message: "Transport created Successfully"
              }
            else
              {
                transport: nil,
                errors: [ transport.errors.full_message ],
                message: []
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
