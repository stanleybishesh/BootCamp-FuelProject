module Mutations
  module Transports
    class DeleteTransport < BaseMutation
      argument :transport_id, ID, required: true

      field :errors, [ String ], null: true
      field :message, String, null: true

      def resolve(transport_id:)
        if current_user
          transport_service = ::Transports::TransportService.new(transport_id: transport_id).execute_delete_transport
          if transport_service.success?
            {
              message: "Transport deleted successfully",
              errors: []
            }
          else
            {
              message: "Transport deletion failed",
              errors: [ transport_service.errors ]
            }
          end
        else
          {
            message: "You are not authorized to perform this action.",
            errors: [ "User not logged in" ]
          }
        end
      end
    end
  end
end
