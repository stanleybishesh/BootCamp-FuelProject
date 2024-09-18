module Resolvers
  module Tenants
    class TenantResolver < BaseResolver
      type Types::Tenants::TenantType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        tenant = Tenant.find_by(id: id)

        if tenant.nil?
          raise GraphQL::ExecutionError, "Tenant not found with #{id}"
        end
        tenant
      end
    end
  end
end
