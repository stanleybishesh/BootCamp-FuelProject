module Mutations
  module Transports
    class DeleteTransport < BaseMutation
      argument :transport_id, ID, required: true

      field :errors, [ String ], null: true
      field :message, String, null: false

      def resolve(transport_id:)
        transport_service = ::Transports::TransportService.new(transport_id: transport_id, current_user: current_user).execute_delete_transport
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
      end
    end
  end
end
