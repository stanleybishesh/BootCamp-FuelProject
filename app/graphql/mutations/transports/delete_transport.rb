module Mutations
  module Transports
    class DeleteTransport < BaseMutation
      argument :transport_id, ID, required: true
      # argument :tenant_id, ID, required: true


      # field :transport, Types::Transports::TransportType, null: false
      field :errors, [ String ], null: true
      field :message, String, null: false


      def resolve(transport_id:)
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
          transport = Transport.find(transport_id)
            if transport
              transport.destroy
              {
                message: "Transport deleted",
                errors: []
              }
            else
              {
                message: "Failed to delete Transport",
                errors: [ "Transport not found or could not be deleted" ]
              }
            end
          end
        else
          raise GraphQL::ExecutionError, "Transport not found"
        end
      end
    end
  end
end
