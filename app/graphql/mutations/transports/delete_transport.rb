module Mutations
  module Transports
    class DeleteTransport < BaseMutation
      argument :id, ID, required: true
      # argument :tenant_id, ID, required: true


      # field :transport, Types::Transports::TransportType, null: false
      field :errors, [ String ], null: true
      field :message, String, null: false


      def resolve(id:)
        # tenant = Tenant.find_by(id: tenant_id)
        transport = Transport.find_by(id: id)

         if transport.nil?
          return {
            message: "Failed to delete transport",
            errors: [ "Transport not found" ]
          }
         end

        if transport.destroy
          {
            Message: "Transport deleted",
            errors: []
          }
        else
          {
            message: "Failed to delete Transport",
            errors: [ "Transport not found or couldnot be deleted" ]
          }
        end
      end
    end
  end
end
