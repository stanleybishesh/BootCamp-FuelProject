# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [ Types::NodeType, null: true ], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ ID ], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :user_login, resolver: Resolvers::Users::UserLogin
    field :fetch_tenant, resolver: Resolvers::Tenants::TenantResolver
    field :get_all_clients, resolver: Resolvers::Clients::GetAllClients
    field :get_client_by_id, resolver: Resolvers::Clients::GetClientById
    field :get_all_transport, resolver: Resolvers::Transports::TransportResolver
    field :get_all_transport_by_vehicle_type, resolver: Resolvers::Transports::TransportVehicleTypeResolver
  end
end
