module Mutations
  module Transports
    class DeleteTransport < BaseMutation
      argument :transport_id, ID, required: true

      field :errors, [ String ], null: true
      field :message, String, null: false

      def resolve(transport_id:)
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
          transport = Transport.find(transport_id)
            if transport.destroy
              {
                message: "Transport deleted",
                errors: []
              }
            else
              {
                message: "Failed to delete Transport",
                errors: [ transport.errors.full_messages ]
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
