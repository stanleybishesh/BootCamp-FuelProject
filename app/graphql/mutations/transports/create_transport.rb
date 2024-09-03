module Mutations
  module Transports
    class CreateTransport < BaseMutation
      argument :transport_info, Types::InputObjects::MakeTransportInputType, required: true

      field :transport, Types::Transports::TransportType, null: true
      field :errors, [ String ], null: false

      def resolve(transport_info:)
        transport_attr = transport_info.to_h
        tenant = Tenant.find_by(id: transport_info.tenant_id)
        raise GraphQL::ExecutionError, "Teanant does not exist !" if tenant.nil?

        transport = tenant.transports.new(transport_attr)

        if transport.save
          {
            transport: transport,
            errors: []
          }
        else
          {
            transport: nil,
            errors: transport.errors.full_message
          }
        end
      end
    end
  end
end
